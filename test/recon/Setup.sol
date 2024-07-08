// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {VotingEscrow} from "src/VotingEscrow.sol";
import {MockERC20} from "src/MockERC20.sol";


abstract contract Setup is BaseSetup {

    VotingEscrow ve;
    MockERC20 token_base;
    MockERC20 token_deposit;

    function setup() internal virtual override {
        token_base = new MockERC20();
        token_deposit = new MockERC20();      

        ve = new VotingEscrow(address(token_base), address(token_deposit), address(0xa47), address(this));


        token_base.mint(address(this), 1e27);
        token_deposit.mint(address(this), 1e27);
        token_base.approve(address(ve), type(uint256).max);
        token_deposit.approve(address(ve), type(uint256).max);
        
    }

        /// TODO: Invariant Test should be smth where at end we have token and not oFlow token
    // Gas has got to be a part of it
    // IDK if medusa tries gas griefing
}
