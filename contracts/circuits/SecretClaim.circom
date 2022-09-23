pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";

/*This circuit template hashes key + secret with Poseidon*/

template SecretClaim () {

   // Declaration of signals.
   signal input key;
   signal input secret;
   signal input recipient;
   signal output hash;
   signal output address;

   component poseidonHash = Poseidon(2);
    poseidonHash.inputs[0] <== key;
    poseidonHash.inputs[1] <== secret;

    hash <== poseidonHash.out;
    address <== recipient;
}

component main = SecretClaim();