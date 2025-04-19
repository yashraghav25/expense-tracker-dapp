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

## Installation

**Clone the repository:**
   ```bash
   git clone https://github.com/your-repository/expense-tracker-dapp.git
   cd expense-tracker-dapp
