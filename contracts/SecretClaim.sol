// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

import "./SecretClaimVerifier_plonk.sol";
import "hardhat/console.sol";

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}

/// @title An example airdrop contract utilizing a zk-proof of MerkleTree inclusion.
contract SecretClaim is SecretClaimVerifier_plonk {
    uint public hashedPassword;

    constructor(
        uint _hashedPassword
    ) {
        hashedPassword = _hashedPassword;
    }

    function verifyZkProof(bytes calldata proof) public {
        uint[] memory pubSignals = new uint[](2);
        pubSignals[0] = uint256(hashedPassword);
        pubSignals[1] = uint256(uint160(msg.sender));
        console.log("account", msg.sender);
        console.log("pubsignal uint hash", pubSignals[0]);
        console.log("pubsignal address", pubSignals[1]);
        // bool result = this.verifyProof("123",pubSignals);
        // console.log("called");
        // console.log("result",result);
        require(this.verifyProof(proof,pubSignals), "Proof verification failed");
    }
}