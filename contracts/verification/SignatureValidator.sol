//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SignatureValidator {
    function getHash(string memory _str) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(_str));
    }

    function getEthSignedHash(bytes32 _msgHash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _msgHash));
    }

    function verify(bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns(address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSignature(bytes memory _sig) public pure returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}