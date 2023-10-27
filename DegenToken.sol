// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenGamingToken is ERC20, Ownable {
    uint256 public constant initialSupply = 1000000 * 10**18; // Initial supply of 1,000,000 tokens

    event TokensMinted(address indexed to, uint256 amount);
    event TokensTransferred(
        address indexed from,
        address indexed to,
        uint256 amount
    );
    event TokensRedeemed(address indexed from, uint256 itemId, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

    struct Item {
        uint256 itemId;
        string itemName;
    }

    struct Owner {
        address ownerAddress;
        uint256[] itemIds;
    }

    Item[] public items;
    Owner[] public owners;

    mapping(uint256 => bool) public itemExists;
    mapping(address => uint256) public ownerToIndex; 

    constructor() ERC20("Degen Gaming Token", "DGT") {
        _mint(msg.sender, initialSupply);
        emit TokensMinted(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    function transferTokens(address to, uint256 amount) public {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
        emit TokensTransferred(msg.sender, to, amount);
    }

    function addNewItem(uint256 itemId, string memory itemName)
        public
        onlyOwner
    {
        require(!itemExists[itemId], "Item already exists");
        items.push(Item(itemId, itemName));
        itemExists[itemId] = true;
    }

    function redeemTokens(uint256 itemId) public {
        require(itemExists[itemId], "Item does not exist");
        require(balanceOf(msg.sender) >= 100, "Insufficient balance");
        _burn(msg.sender, 100);
        emit TokensRedeemed(msg.sender, itemId, 100);

        // Find the owner index or create a new owner
        uint256 ownerIndex = ownerToIndex[msg.sender];
        if (ownerIndex == 0) {
            // Owner does not exist, create a new owner
            Owner memory newOwner = Owner(msg.sender, new uint256[](0));
            ownerIndex = owners.length;
            owners.push(newOwner);
            ownerToIndex[msg.sender] = ownerIndex;
        }

        // Add the itemId to the owner's item collection
        owners[ownerIndex].itemIds.push(itemId);
    }

    function burnTokens(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
        emit TokensBurned(msg.sender, amount);
    }

    function checkTokenBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function ItemList() public view returns (Item[] memory) {
        return items;
    }

    function getOwnedItems() public view returns (uint[] memory) {
        uint ownerIndex = ownerToIndex[msg.sender];
        if (ownerIndex == 0) {
            // The sender is not an owner, return an empty array or a special value
            return new uint[](0);
        } else {
            // The sender is an owner, return their itemIds
            return owners[ownerIndex].itemIds;
        }
}
}
