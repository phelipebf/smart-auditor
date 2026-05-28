# Reentrancy

SWC-107. The canonical EVM vulnerability: an external call hands control to another contract
which then re-enters the caller before its state has been updated.

## Variants

1. **Classic single-function reentrancy.** `withdraw()` sends ETH via `call{value:}` then
   updates `balances[msg.sender] = 0`. Attacker's `receive()` re-enters `withdraw()` with the
   unchanged balance.
2. **Cross-function reentrancy.** Function A sends ETH before updating shared state. Attacker
   re-enters function B (which reads the stale state) rather than A. A `nonReentrant` modifier
   on A alone does not protect B unless they share the lock.
3. **Cross-contract reentrancy.** Contract X calls contract Y, Y calls Z, Z re-enters X. Can
   bypass per-contract guards.
4. **Read-only reentrancy.** A `view` function that reads state the protocol assumes is
   consistent, called during an external call. Curve's 2022 incident is the canonical example:
   attackers called a pool's `get_virtual_price()` mid-reentrancy to manipulate downstream
   protocols that trusted it.
5. **ERC-777 / ERC-1155 callback reentrancy.** `transfer`/`safeTransfer` on callback-enabled
   tokens hands control to the recipient's hook (`tokensToSend` / `onERC1155Received`). Any
   protocol assuming `IERC20.transfer` is inert is at risk.

## Detection heuristics

- External call (`.call`, `.transfer`, `.send`, any external contract call, ERC-20 `transfer`/
  `transferFrom`, `safeTransferFrom`) followed by **any** state mutation of caller's storage.
- Absence of `ReentrancyGuard` / `nonReentrant` on functions that touch both a mapping and
  perform an external call.
- Custom locks using a `bool locked` pattern that are correct in isolation but absent on a
  sibling function reading the same state.
- Any use of `call{value: x}("")` without Checks-Effects-Interactions.

## Recommendation template

> Apply Checks-Effects-Interactions: move all state mutations before the external call. Where
> that is not possible (e.g. callback-driven patterns), use OpenZeppelin's `ReentrancyGuard`
> and apply `nonReentrant` to every function touching the shared state — not just the one
> making the external call.

## References

- SWC-107: https://swcregistry.io/docs/SWC-107
- ConsenSys Diligence: https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/
- Curve read-only reentrancy: https://chainsecurity.com/curve-lp-oracle-manipulation-post-mortem/
