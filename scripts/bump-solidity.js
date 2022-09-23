const fs = require("fs");
const solidityRegex = /pragma solidity \^\d+\.\d+\.\d+/

const verifierRegex = /contract Verifier/

let content, bumped;;

content = fs.readFileSync("./contracts/SecretClaimVerifier.sol", { encoding: 'utf-8' });
bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.9');
bumped = bumped.replace(verifierRegex, 'contract SecretClaimVerifier');
fs.writeFileSync("./contracts/SecretClaimVerifier.sol", bumped);

content = fs.readFileSync("./contracts/SecretClaimVerifier_plonk.sol", { encoding: 'utf-8' });
bumped = content.replace(solidityRegex, 'pragma solidity ^0.8.9');
bumped = bumped.replace("contract PlonkVerifier", 'contract SecretClaimVerifier_plonk');
fs.writeFileSync("./contracts/SecretClaimVerifier_plonk.sol", bumped);