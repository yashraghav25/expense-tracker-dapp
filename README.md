# On-Chain Expense Tracker DApp

This decentralized application (DApp) allows users to track their expenses on the Ethereum blockchain. It interacts with a smart contract that stores expenses and user data on the blockchain. Users can register their name, add expenses, and track how much they owe or are owed. The DApp is built using React, the `ethers.js` library for blockchain interaction, and connects to MetaMask for Ethereum wallet management.

## Features

1. **Display connected wallet address**  
   Displays the currently connected Ethereum wallet address.

2. **Display total registered users**  
   Fetches and displays how many users are currently registered on the contract.

3. **Show last expense label**  
   Fetches and displays the description of the most recent expense added to the contract.

4. **Check if wallet is registered**  
   Checks if the connected wallet is already registered in the contract.

5. **Show user’s name**  
   Displays the name of the currently registered user from the blockchain.

## Technologies Used

- **React**: Front-end framework for building the user interface.
- **ethers.js**: A library for interacting with the Ethereum blockchain.
- **Solidity**: Smart contract language (Expense Tracker contract).
- **MetaMask**: Ethereum wallet browser extension for managing accounts and transactions.
## Updated Features

### 1. **Get Your Own Name**
   Allows a user to retrieve their registered name using their wallet address.

   **Smart Contract Function**:
   ```solidity
   function getYourName() public view returns (string memory) {
       require(
           people[msg.sender].walletAddress != address(0),
           "User not registered"
       );
       return people[msg.sender].name;
   }
```
### 2. **Check if a user is registered**
   Returns true or false based on whether a user has registered.

   **Smart Contract Function**:
   ```solidity
   function isUserRegistered(address _addr) public view returns (bool) {
        return people[_addr].walletAddress != address(0);
    }
```
### 3. **Get total number of registered people**
   Returns the total number of registered users on the platform.

   **Smart Contract Function**:
   ```solidity
   function isUserRegistered(address _addr) public view returns (bool) {
        return people[_addr].walletAddress != address(0);
    }
```
### 4. **Get label of the last expense**
   Fetches the description of the most recently added expense.

   **Smart Contract Function**:
   ```solidity
   function getLastExpenseLabel() public view returns (string memory) {
        require(expenseCount > 0, "No expenses yet");
        return expenses[expenseCount - 1].label;
    }
```
### 5. **Update your name**
   Lets a user update their registered name.

   **Smart Contract Function**:
   ```solidity
   function updateName(string memory _newName) public {
        require(bytes(_newName).length > 0, "New name cannot be empty");
        require(
            people[msg.sender].walletAddress != address(0),
            "User not registered"
        );

        people[msg.sender].name = _newName;
        emit PersonUpdated(msg.sender, _newName);
    }
```


