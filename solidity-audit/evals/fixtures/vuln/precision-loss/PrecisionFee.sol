// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Intentionally vulnerable contract — for testing purposes only.
///         Accumulates user deposits and charges a configurable fee per
///         withdrawal. The fee math rounds the wrong way and truncates to
///         zero on small amounts.
contract PrecisionFee {
    mapping(address => uint256) public balances;

    /// Fee in basis points (10000 = 100%).
    uint256 public feeBps = 30; // 0.3%
    address public feeSink;
    uint256 public accumulatedFees;

    constructor(address _sink) {
        feeSink = _sink;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "insufficient");

        // BUG: division before multiplication.
        // For amount < 10_000 / feeBps (≈333 wei), `amount / 10_000` is 0,
        // so the user pays no fee. A griefing user can withdraw in dust
        // amounts and bypass fees entirely.
        uint256 fee = amount / 10_000 * feeBps;

        balances[msg.sender] -= amount;
        accumulatedFees += fee;

        (bool ok, ) = msg.sender.call{value: amount - fee}("");
        require(ok, "transfer failed");
    }
}
