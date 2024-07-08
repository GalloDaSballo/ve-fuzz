// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import "forge-std/console2.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();


    }
    function test_crytic() public {
        // TODO: add failing property tests here for debugging

        // Send Flow tokens
        // Set claimable
        // See that you got the amount

        flow.mint(address(gauge), 1e18);
        gauge.setEarned(address(flow), address(this), 1e18);

        uint256 oTokenB4 = oFlow.balanceOf(address(this));

        address[] memory claims = new address[](1);
        claims[0] = address(flow);
        gauge.getReward(address(this), claims);

        uint256 oTokenAfter = oFlow.balanceOf(address(this));

        console2.log("oTokenB4", oTokenB4);
        console2.log("oTokenAfter", oTokenAfter);
    }
}
