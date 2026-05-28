# Arithmetic & precision

Solidity ≥ 0.8 has checked arithmetic by default — overflow/underflow revert. But the class
of arithmetic bugs is broader than `+`/`-`. Most real-world issues today come from precision
loss and rounding direction, not raw overflow.

## Real risks in Solidity 0.8+

1. **`unchecked { ... }` blocks.** Explicit opt-out. Every `unchecked` block needs a
   justification (proved can't overflow, or overflow is intended e.g. in an LP accumulator).
2. **Division before multiplication.** `a / b * c` rounds `a/b` to zero when `a < b`, then
   multiplies by `c`, giving zero. Always order as `a * c / b`.
3. **Precision loss from small denominators.** `fee = amount * feeBps / 10_000`. If `amount`
   < 10000 / feeBps, `fee == 0`. Protocols have lost fees on small trades this way.
4. **Rounding direction.** A share-price denominated asset where `shares = assets * total /
   supply` should round *down* when minting shares and *up* when redeeming them. Off-by-one
   in either direction lets a depositor extract value.
5. **First-depositor / vault inflation attack.** ERC-4626 vaults where the first depositor
   donates shares to themselves and a subsequent large deposit rounds to zero shares for the
   victim. Mitigation: mint "dead shares" on first deposit, or use OZ's `_decimalsOffset`.
6. **Signed/unsigned mixing.** `int256` to `uint256` casts at boundaries; negative values
   wrapping produce absurd positives.
7. **Integer-size truncation.** `uint256` downcast to `uint128` without `SafeCast`. Silent in
   `unchecked`; otherwise reverts but errors may be caught elsewhere.
8. **Fixed-point math.** Protocols implementing their own fixed-point (WAD/RAY) must preserve
   scale through chains of operations; mixing 18-decimal with 6-decimal tokens (USDC vs ETH)
   is a frequent source of bugs.

## Detection heuristics

- Any `unchecked` block — read its justification (or lack thereof).
- Division operations on the left of multiplication.
- Fee calculations with no minimum threshold.
- ERC-4626 vault `deposit`/`mint` without `_decimalsOffset` or dead-shares seeding.
- Casts between `uint*` of different sizes without `SafeCast`.
- Math on token amounts across tokens with different decimals without normalization.

## Recommendation templates

> Reorder operations so that multiplication happens before division:
> `a * c / b` rather than `a / b * c`. For rounding-sensitive calculations, explicitly choose
> `mulDivUp` vs `mulDivDown` (OZ `Math`, Solmate `FixedPointMathLib`).

> Protect against ERC-4626 inflation by (a) seeding the vault with dead shares on
> first deposit, or (b) using OZ's `ERC4626` with `_decimalsOffset() >= 3`.

> Wrap all downcasts in `SafeCast.toUint128` / `.toUint64` from OpenZeppelin.

## References

- SWC-101: https://swcregistry.io/docs/SWC-101
- ERC-4626 inflation attack: https://blog.openzeppelin.com/a-novel-defense-against-erc4626-inflation-attacks
- OZ Math: https://docs.openzeppelin.com/contracts/5.x/api/utils#Math
