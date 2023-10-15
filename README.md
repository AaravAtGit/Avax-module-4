# DegenToken.sol

DegenToken.sol is a Solidity contract that implements an ERC20 token with some additional functionality. This token is used within a gaming ecosystem to allow players to earn and redeem tokens for in-game items.

## Functionality Overview

The contract implements the following functionality:

- Minting of tokens
- Transfer of tokens between addresses
- Addition of new items to the system
- Redeeming tokens for items
- Burning of tokens

## Details

### Contract Initialization

The contract is initialized with the name "Degen Gaming Token" and the symbol "DGT". The initial supply of tokens is 1,000,000.

### Minting of Tokens

The `mint` function can be called by the contract owner to mint new tokens and send them to a specified address. The `amount` parameter specifies the number of tokens to be minted.

The event `TokensMinted` is emitted when new tokens are minted.

### Transfer of Tokens

The `transferTokens` function can be called by any address to transfer tokens to another address. The `amount` parameter specifies the number of tokens to be transferred.

The event `TokensTransferred` is emitted when tokens are transferred.

### Addition of New Items

The `addNewItem` function can be called by the contract owner to add a new item to the system. The `itemId` parameter specifies the unique identifier for the item, and the `itemName` parameter specifies the name of the item.

The event `NewItemAdded` is emitted when a new item is added.

### Redeeming Tokens for Items

The `redeemTokens` function can be called by any address to redeem tokens for a specified item. The `itemId` parameter specifies the unique identifier for the item, and the number of tokens required to redeem the item is always 100.

The event `TokensRedeemed` is emitted when tokens are redeemed for an item.

### Burning of Tokens

The `burnTokens` function can be called by any address to burn a specified number of tokens. The `amount` parameter specifies the number of tokens to be burned.

The event `TokensBurned` is emitted when tokens are burned.

### Other Functions

The contract also contains the following additional functions:

- `checkTokenBalance`: Returns the balance of tokens for a specified address.
- `ItemList`: Returns an array of all items in the system.
- `getOwnedItems`: Returns an array of item ids owned by the calling address.
