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

    uint256 maxLockId = 0;

    function checkpoint() public {
        ve.checkpoint();
    }
    function deposit_for(uint _tokenId, uint _value) public {
        _tokenId = _clampId(_tokenId);
        ve.deposit_for(_tokenId, _value);
    }
    function create_lock(uint _value, uint _lock_duration) public {
        
        maxLockId = ve.create_lock(_value, _lock_duration);
    }
    function create_lock_for(uint _value, uint _lock_duration, address _to, bool self) public {
        maxLockId = ve.create_lock_for(_value, _lock_duration, self ? address(this) : _to);
    }
    function increase_amount(uint _tokenId, uint _value) public {
        _tokenId = _clampId(_tokenId);
        ve.increase_amount(_tokenId, _value);
    }
    function enable_max_lock(uint _tokenId) public {
        _tokenId = _clampId(_tokenId);
        ve.enable_max_lock(_tokenId);
    }
    function disable_max_lock(uint _tokenId) public {
        _tokenId = _clampId(_tokenId);
        ve.disable_max_lock(_tokenId);
    }
    function max_lock(uint _tokenId) public {
        _tokenId = _clampId(_tokenId);
        ve.max_lock(_tokenId);
    }
    function max_lock_bulk() public {
        ve.max_lock_bulk();
    }
    function increase_unlock_time(uint _tokenId, uint _lock_duration) public {
        _tokenId = _clampId(_tokenId);
        ve.increase_unlock_time(_tokenId, _lock_duration);
    }
    function withdraw(uint _tokenId) public {
        _tokenId = _clampId(_tokenId);
        ve.withdraw(_tokenId);
    }
    function merge(uint _from, uint _to) public {
        _from = _clampId(_from);
        _to = _clampId(_to);
        ve.merge(_from, _to);
    }
    function split(uint _tokenId,uint amount) public {
        _tokenId = _clampId(_tokenId);
        ve.split(_tokenId, amount);
    }

    function _clampId(uint256 id) internal returns (uint) {
        return id %= maxLockId + 1;
    }


    function check_lock_sound() public {
        for(uint256 i; i < maxLockId; i++) {
            (int128 amount, uint end) = ve.locked(i);
            t(amount >= 0, "Cannot have lock under zero");
        }
    }


}
