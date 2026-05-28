# Oracle manipulation

A protocol that trusts a manipulable price feed can be drained via flash-loan-backed spot
trades. Oracle bugs have caused more DeFi losses than any other class.

## Patterns and pitfalls

1. **Spot-price-from-DEX as oracle.** Using `reserve0 / reserve1` from a Uniswap V2 pair, or
   `slot0().sqrtPriceX96` from Uniswap V3, as an in-protocol price. A single-block flash loan
   manipulates this. Always use a TWAP (time-weighted average price) over ≥ 30 minutes, or a
   Chainlink feed.
2. **Uniswap V3 TWAP with insufficient lookback.** TWAPs over 1-5 blocks are still
   manipulable by a miner/validator. Industry minimum is ~30 min (1800s).
3. **Stale Chainlink price.** Calling `latestRoundData()` without checking `updatedAt` against
   `block.timestamp` — a stalled feed returns the last stored value indefinitely. Also check
   `answeredInRound >= roundId` to avoid incomplete rounds.
4. **No deviation / heartbeat bounds.** Trusting `answer` without validating against a sane
   range (min/max) lets a severely depegged asset be priced as if healthy.
5. **Single-oracle single-point-of-failure.** A depegged/paused oracle drags the whole
   protocol. Recommend: primary + secondary with deviation check.
6. **Wrong decimals / invalid pair.** Using a USDC/ETH feed as if it were USDC/USD, or
   a pair with 8 decimals as 18. Silent wrong answers.
7. **L2 sequencer downtime.** On Arbitrum/Optimism, Chainlink feeds can be stale during
   sequencer outages. Use the L2 sequencer uptime feed to reject liquidations during
   downtime (Chainlink provides this).
8. **LP-token-as-collateral.** Pricing a Curve/Balancer LP token by reading the pool's
   `get_virtual_price()` is vulnerable to read-only reentrancy (see `reentrancy.md`) and to
   imbalance manipulation.

## Detection heuristics

- Any call to `pair.getReserves()` or `pool.slot0()` whose result feeds a pricing calculation.
- `latestAnswer()` or `latestRoundData()` where `updatedAt` / `answeredInRound` are discarded.
- A single price feed with no fallback, used in a liquidation / collateral / redemption path.
- Protocols running on Arbitrum/Optimism/Base that do not consult the L2 sequencer uptime
  feed.
- TWAP lookback < 30 minutes.

## Recommendation template

> Price this asset via a Chainlink feed with explicit staleness checks (updatedAt + heartbeat
> tolerance) and round-completeness checks (answeredInRound >= roundId). If a DEX-derived
> price is unavoidable, use a Uniswap V3 TWAP with ≥ 1800s lookback and treat it as a fallback
> rather than a primary.

## References

- Chainlink docs: https://docs.chain.link/data-feeds/api-reference
- Uniswap V3 oracle: https://docs.uniswap.org/concepts/protocol/oracle
- ChainSecurity Curve writeup: https://chainsecurity.com/curve-lp-oracle-manipulation-post-mortem/
