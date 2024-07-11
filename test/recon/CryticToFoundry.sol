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

// forge test --match-test test_check_withdrawal_0 -vv 

 
function test_check_withdrawal_0() public {
  
   vm.roll(35353);
   vm.warp(335755);
   create_lock(8, 16635278);
  
   vm.roll(35472);
   vm.warp(335877);
    (int128 amount, uint end) = ve.locked(_clampId(115792089237316195423570985008687907853269984665640564039457584007913118484501));
    console2.log("end", end);
    console2.log("block.timestamp", block.timestamp);

   check_withdrawal(115792089237316195423570985008687907853269984665640564039457584007913118484501);
}
		
		
}
