// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExpenseTracker {
    struct Person {
        string name;
        address walletAddress;
    }

    struct Expense {
        uint256 id;
        string label;
        uint256 timestamp;
        mapping(address => uint256) amountPaid;
        mapping(address => uint256) amountOwed;
        address[] participants;
    }

    mapping(uint256 => Expense) private expenses;
    mapping(address => Person) private people;
    address[] private registeredPeople;
    uint256 public expenseCount;

    event PersonRegistered(address indexed walletAddress, string name);
    event PersonUpdated(address indexed walletAddress, string newName);
    event ExpenseAdded(uint256 indexed expenseId, string label);
    event DebtSettled(address indexed from, address indexed to, uint256 amount);

    function registerPerson(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(
            people[msg.sender].walletAddress == address(0),
            "Person already registered"
        );

        people[msg.sender] = Person(_name, msg.sender);
        registeredPeople.push(msg.sender);
        emit PersonRegistered(msg.sender, _name);
    }

    function updateName(string memory _newName) public {
        require(bytes(_newName).length > 0, "New name cannot be empty");
        require(
            people[msg.sender].walletAddress != address(0),
            "User not registered"
        );

        people[msg.sender].name = _newName;
        emit PersonUpdated(msg.sender, _newName);
    }

    function isUserRegistered(address _addr) public view returns (bool) {
        return people[_addr].walletAddress != address(0);
    }

    function getYourName() public view returns (string memory) {
        require(
            people[msg.sender].walletAddress != address(0),
            "User not registered"
        );
        return people[msg.sender].name;
    }

    function getTotalRegisteredUsers() public view returns (uint256) {
        return registeredPeople.length;
    }

    function getLastExpenseLabel() public view returns (string memory) {
        require(expenseCount > 0, "No expenses yet");
        return expenses[expenseCount - 1].label;
    }

    function addExpense(
        string memory _label,
        address[] memory _participants,
        uint256[] memory _amountsPaid,
        uint256[] memory _amountsOwed
    ) public {
        require(bytes(_label).length > 0, "Label cannot be empty");
        require(_participants.length > 0, "No participants");
        require(
            _participants.length == _amountsPaid.length,
            "Participants and amounts paid must have the same length"
        );
        require(
            _participants.length == _amountsOwed.length,
            "Participants and amounts owed must have the same length"
        );

        uint256 expenseId = expenseCount++;
        Expense storage newExpense = expenses[expenseId];
        newExpense.id = expenseId;
        newExpense.label = _label;
        newExpense.timestamp = block.timestamp;

        for (uint256 i = 0; i < _participants.length; i++) {
            require(_participants[i] != address(0), "Invalid participant address");

            newExpense.participants.push(_participants[i]);
            newExpense.amountPaid[_participants[i]] = _amountsPaid[i];
            newExpense.amountOwed[_participants[i]] = _amountsOwed[i];
        }

        emit ExpenseAdded(expenseId, _label);
    }

    function getPerson(
        address _addr
    ) public view returns (string memory name, address walletAddress) {
        Person storage p = people[_addr];
        return (p.name, p.walletAddress);
    }

    function getExpenseParticipants(
        uint256 _expenseId
    ) public view returns (address[] memory) {
        require(_expenseId < expenseCount, "Expense does not exist");
        return expenses[_expenseId].participants;
    }

    function getExpenseBasicInfo(
        uint256 _expenseId
    ) public view returns (uint256, string memory, uint256) {
        require(_expenseId < expenseCount, "Expense does not exist");
        Expense storage expense = expenses[_expenseId];
        return (expense.id, expense.label, expense.timestamp);
    }

    function getAmountPaid(
        uint256 _expenseId,
        address _participant
    ) public view returns (uint256) {
        require(_expenseId < expenseCount, "Expense does not exist");
        return expenses[_expenseId].amountPaid[_participant];
    }

    function getAmountOwed(
        uint256 _expenseId,
        address _participant
    ) public view returns (uint256) {
        require(_expenseId < expenseCount, "Expense does not exist");
        return expenses[_expenseId].amountOwed[_participant];
    }

    function getNetBalance(address _person) public view returns (int256) {
        int256 netBalance = 0;
        for (uint256 i = 0; i < expenseCount; i++) {
            netBalance += int256(expenses[i].amountPaid[_person]);
            netBalance -= int256(expenses[i].amountOwed[_person]);
        }
        return netBalance;
    }

    function settleDebt(address _to) public payable {
        require(_to != address(0), "Invalid recipient address");
        require(_to != msg.sender, "Cannot settle debt with yourself");

        emit DebtSettled(msg.sender, _to, msg.value);
    }

    function getAllRegisteredPeople() public view returns (address[] memory) {
        return registeredPeople;
    }
}
