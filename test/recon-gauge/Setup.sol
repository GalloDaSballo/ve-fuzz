// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {Gauge} from "src/Gauge.sol";
import {MockERC20} from "src/MockERC20.sol";
import {OptionTokenV4} from "src/OptionTokenV4.sol";

contract MockVE {
    // Just return flow / fake flow

    address public baseToken;

    constructor(address _baseToken) {
        baseToken = _baseToken;
    }
}
contract MockVoter {
    // Just return flow / fake flow

    address public _ve;

    constructor(address ve) {
        _ve = ve;
    }

    function distribute(address g) external {
        // Nothing
    }
}

// Give it tokens
// Fuzz it
// With 2 versions
contract MockGauge is Gauge {

    constructor(address _stake, address _external_bribe, address  __ve, address _voter, address _oFlow, address _gaugeFactory, bool _forPair, address[] memory _allowedRewardTokens) 
    Gauge(_stake, _external_bribe, __ve, _voter, _oFlow, _gaugeFactory, _forPair, _allowedRewardTokens)
    {
    
    }
    mapping (address => mapping(address => uint256)) public _earned;

    function earned(address token, address account) public override view returns (uint) {
        return _earned[token][account];
    }


    function setEarned(address token, address account, uint256 amt) external {
        _earned[token][account] = amt;
    }
}

abstract contract Setup is BaseSetup {

    MockERC20 stake;
    MockERC20 flow;

    MockVE ve;
    MockVoter voter;
    OptionTokenV4 oFlow;

    MockGauge gauge;

    function setup() internal virtual override {
        stake = new MockERC20();
        flow = new MockERC20();      

        ve = new MockVE(address(flow));

        voter = new MockVoter(address(ve));

        oFlow = new OptionTokenV4(
            "o",
            "O",
            address(this),
            address(flow),
            address(0x123), // Treasury
            address(voter), // Voter
            address(0x123), //Router
            false,
            false,
            false,
            123
        );

        

        address[] memory _allowedRewardTokens = new address[](1);
        _allowedRewardTokens[0] = address(flow);

        gauge = new MockGauge(
            address(stake),
            address(0),
            address(ve),
            address(voter),
            address(oFlow),
            address(0),
            false, // Not pair
            _allowedRewardTokens
        ); 


        // minter role
        oFlow.grantRole(oFlow.MINTER_ROLE(), address(gauge));
    }

        /// TODO: Invariant Test should be smth where at end we have token and not oFlow token
    // Gas has got to be a part of it
    // IDK if medusa tries gas griefing
}
