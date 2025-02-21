// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DynamicNFT {
    mapping(uint256 => address) private _owners;
    mapping(uint256 => uint256) private _timestamps;

    function mint(uint256 tokenId) public {
        require(_owners[tokenId] == address(0), "Token already exists");
        _owners[tokenId] = msg.sender;
        _timestamps[tokenId] = block.timestamp;
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _owners[tokenId];
    }

    function getMetadata(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");

        uint256 elapsed = block.timestamp - _timestamps[tokenId];
        
        if (elapsed < 1 days) {
            return "Metadata: Stage 1 - Freshly Minted";
        } else if (elapsed < 7 days) {
            return "Metadata: Stage 2 - Developing";
        } else if (elapsed < 30 days) {
            return "Metadata: Stage 3 - Matured";
        } else {
            return "Metadata: Stage 4 - Ancient";
        }
    }
}
