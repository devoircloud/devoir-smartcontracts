pragma solidity ^0.5.6;

contract DevoirCashback {
    address _contractOwner = msg.sender;

    mapping(string => address) public emailAssigns;
    mapping(address => string) public addressAssigns;
    mapping(string => uint) public balance;

  // Add Money
  function deposit(string memory email) public payable {
      require(msg.value > 0, "Should be some asset attachments");
      balance[email] = balance[email] + msg.value;
  }

  // Withdraw Money
  function withdraw() public payable {
      string memory email = addressAssigns[msg.sender];

      if (balance[email] > 0) {
          msg.sender.transfer(balance[email]);
          balance[email] = 0;
      }
  }

    function addAssignment (string memory email) public {
        require(emailAssigns[email] != 0x0000000000000000000000000000000000000000, "Mapping already exists");

        emailAssigns[email] = msg.sender;
        addressAssigns[msg.sender] = email;
    }

    function getAssignmentForEmail (string memory email) public view returns(address, uint) {
        return (emailAssigns[email], balance[email]);
    }

    function getAssignmentForAddress (address owner) public view returns (string memory, uint) {
        string memory email = addressAssigns[owner];

        return (email, balance[email]);
    }
}
