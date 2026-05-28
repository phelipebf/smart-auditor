# ERC-20 pitfalls

"ERC-20" is a de-facto standard with many non-conforming implementations in the wild.
Protocols that interact with arbitrary ERC-20s must handle these.

## Patterns and pitfalls

1. **Missing return value.** USDT (Tether) does not return `bool` on `transfer`/`transferFrom`.
   Naive `require(token.transfer(...))` reverts because there is no return value to decode.
   Always use `SafeERC20.safeTransfer` / `.safeTransferFrom`.
2. **Fee-on-transfer tokens.** Some tokens (reflection tokens, some CEX wrappers) take a fee
   during `transfer`, so the recipient receives less than `amount`. Protocols that credit the
   user with `amount` rather than `actualReceived` can be drained.
3. **Rebasing tokens.** stETH, aTokens — balances change without `transfer` events. Protocols
   storing a fixed `balanceOf` snapshot drift out of sync.
4. **Approve race.** The classic ERC-20 approve-non-zero-to-non-zero risk: going from 100 to
   50 allowance via `approve(50)` lets a front-running spender pull 150 total. Mitigation:
   `safeIncreaseAllowance` / `safeDecreaseAllowance`, or zeroing first.
5. **`blocklist` / `transfer` reverting on allowed addresses.** USDC can freeze specific
   accounts. A protocol that `transfer`s to a blocklisted user reverts the whole tx.
6. **Tokens with callbacks.** ERC-777 tokens and some ERC-20 extensions call back into the
   receiver during transfer — turns every transfer into a potential reentrancy vector.
7. **Non-standard decimals.** USDC/USDT are 6, WBTC is 8, most others are 18. Hardcoding 18
   for cross-token math silently truncates value.
8. **Token with broken `transferFrom` semantics.** Some tokens (ZRX, older OMG) require
   `approve(0)` before a new non-zero `approve` — `safeApprove` handles this, `approve` does
   not.
9. **Flash-loan / mint-during-transfer tokens.** Protocols that read `totalSupply` mid-call
   can be fed an inflated value.

## Detection heuristics

- Any use of `token.transfer(...)` / `.transferFrom(...)` without `SafeERC20`.
- Pool math that assumes `balanceOf(address(this))` increases by exactly `amount` on
  `transferFrom`.
- Hardcoded `10 ** 18` in amounts involving arbitrary ERC-20 inputs.
- `approve(x)` called when `x != 0` and previous allowance may also be non-zero.
- Protocols that expose integration with "any ERC-20" but no allowlist — should at minimum
  document supported-token assumptions.

## Recommendation template

> Always use `SafeERC20` from OpenZeppelin for `transfer`/`transferFrom`/`approve`. For
> deposits, compute `received = balanceOf(after) - balanceOf(before)` to account for
> fee-on-transfer tokens. For variable-supply / rebasing tokens, either maintain an
> accounting system independent of `balanceOf`, or maintain an allowlist of compatible tokens.

## References

- SafeERC20: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#SafeERC20
- Weird ERC-20 list: https://github.com/d-xo/weird-erc20
