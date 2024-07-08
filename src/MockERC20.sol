// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import 'openzeppelin-contracts/contracts/token/ERC20/ERC20.sol';


contract MockERC20 is ERC20 {
    constructor() ERC20("Mock", "MOCK") {}

    function mint(address to, uint256 amt) external {
        _mint(to, amt);
    }
}