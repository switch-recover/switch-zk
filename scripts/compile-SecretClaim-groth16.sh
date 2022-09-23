#!/bin/bash

cd contracts/circuits

mkdir SecretClaim

if [ -f ./powersOfTau28_hez_final_12.ptau ]; then
    echo "powersOfTau28_hez_final_12.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_12.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_12.ptau
fi

echo "Compiling SecretClaim.circom..."

# compile circuit

circom SecretClaim.circom --r1cs --wasm --sym -o SecretClaim
snarkjs r1cs info SecretClaim/SecretClaim.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup SecretClaim/SecretClaim.r1cs powersOfTau28_hez_final_12.ptau SecretClaim/circuit_0000.zkey
snarkjs zkey contribute SecretClaim/circuit_0000.zkey SecretClaim/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey SecretClaim/circuit_final.zkey SecretClaim/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier SecretClaim/circuit_final.zkey ../SecretClaimVerifier.sol

cd ../..