pragma solidity ^0.5.0;

contract FunctionTypes {

  constructor() public payable { require(msg.value != 0); }

  function withdraw() private {
    require(msg.value == 0, 'dont send funds!');
    address(msg.sender).transfer(address(this).balance);
  }

  function frwd() internal
  { withdraw(); }

  struct Func { function () internal f; }

  function breakIt() public payable {
    require(msg.value != 0, 'send funds!');
    Func memory func;
    func.f = frwd;
    assembly { mstore(func, add(mload(func), callvalue)) }
    func.f();
  }

  uint public count = 2;

  function run(uint256 input) public {
    count *= input;
  }
}
