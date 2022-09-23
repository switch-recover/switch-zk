#!/bin/bash

# [assignment] create your own bash script to compile SecretClaim.circom using PLONK below

cd contracts/circuits

mkdir SecretClaim_plonk

if [ -f ./powersOfTau28_hez_final_12.ptau ]; then
    echo "powersOfTau28_hez_final_12.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_12.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_12.ptau
fi

echo "Compiling SecretClaim.circom..."

# compile circuit

circom SecretClaim.circom --r1cs --wasm --sym -o SecretClaim
snarkjs r1cs info SecretClaim_plonk/SecretClaim.r1cs

# Start a new zkey and make a contribution

snarkjs plonk setup SecretClaim_plonk/SecretClaim.r1cs powersOfTau28_hez_final_12.ptau SecretClaim_plonk/circuit_final.zkey
snarkjs zkey export verificationkey SecretClaim_plonk/circuit_final.zkey SecretClaim_plonk/verification_key.json

# # generate solidity contract
snarkjs zkey export solidityverifier SecretClaim_plonk/circuit_final.zkey ../SecretClaimVerifier_plonk.sol

cd ../..