// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";
import {vm} from "@chimera/Hevm.sol";

abstract contract TargetFunctions is
    BaseTargetFunctions,
    Properties,
    BeforeAfter
{

    // Mint to Option
    function mintToGauge(uint256 amt) public {
        flow.mint(address(gauge), amt);
    }

    // Mint to Option
    function mintToOption(uint256 amt) public {
        flow.mint(address(oFlow), amt);
    }
    // Mint to Self
    function mintToSelf(uint256 amt) public {
        flow.mint(address(this), amt);
    }

    // Set gained
    function setGained(uint256 amt) public {
        gauge.setEarned(address(flow), address(this), amt);
    }

    uint256 b4Option;
    uint256 b4Flow;
    function _update() internal {
        b4Option = oFlow.balanceOf(address(this));
        b4Flow = flow.balanceOf(address(this));
    }

    function _diff() internal returns (uint256, uint256) {
        uint256 newOFlow = oFlow.balanceOf(address(this));
        uint256 newFlow = flow.balanceOf(address(this));

        return (
            newOFlow - b4Option,
            newFlow - b4Flow
        );
    }

    // Claim
    function claim() public {
        address[] memory claims = new address[](1);
        claims[0] = address(flow);

        _update();
        gauge.getReward(address(this), claims);

        (uint256 oF, uint256 fDelta) = _diff();

        t(fDelta == 0, "f delta must be zero");
    }

    // Claim with Capped gas
    function claimWithCappedGas(uint64 gas) public {
        address[] memory claims = new address[](1);
        claims[0] = address(flow);

        _update();
        gauge.getReward{gas: gas}(address(this), claims);

        (uint256 oF, uint256 fDelta) = _diff();

        t(fDelta == 0, "f delta must be zero");
    }

    // // TODO OTHER CLAIMS??
    // function claimWithCappedGas(uint64 gas) public {
    //     address[] memory claims = new address[](1);
    //     claims[0] = address(flow);

    //     _update();
    //     gauge.getReward{gas: gas}(address(this), claims);

    //     (uint256 oF, uint256 fDelta) = _diff();

    //     t(fDelta == 0, "f delta must be zero");
    // }

    // Mint from another acc
    // Transfer from another acc
    // have tokens
    // have exact tokens
    // ACC1 
    // ACC2
    // Mint to Gauge
    // Acc1 Claim Bool
    // Acc1 transferTo2 Bool
    // Acc1 transferTo2 AMT
    // Acc2 Claim Bool
    // Test on Acc2

}
