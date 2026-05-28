// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @notice Intentionally vulnerable contract — for testing purposes only.
///         UUPS implementation that forgets to (a) call `_disableInitializers` in the
///         constructor and (b) restrict `_authorizeUpgrade`, letting anyone claim
///         ownership of the implementation and upgrade the proxy to arbitrary code.
contract Market is Initializable, UUPSUpgradeable {
    address public owner;
    uint256 public totalDeposits;

    // BUG 1: no constructor disabling initializers on the implementation —
    //        anyone can call initialize() on the impl and own it.

    function initialize(address _owner) public initializer {
        owner = _owner;
    }

    // BUG 2: _authorizeUpgrade has no access control — any account can call
    //        upgradeTo/upgradeToAndCall and rewrite the implementation.
    function _authorizeUpgrade(address newImpl) internal override {}

    function deposit() external payable {
        totalDeposits += msg.value;
    }
}
