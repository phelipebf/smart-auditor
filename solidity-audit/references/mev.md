# MEV & front-running

Miner/validator-extractable value: anyone with transaction ordering power can sandwich,
back-run, or censor a user's transaction. Not every user action is at risk — but
protocol-level assumptions often break under MEV pressure.

## Patterns and pitfalls

1. **Unprotected swap without `minAmountOut`.** A router call `swapExactTokensForTokens` that
   passes `amountOutMin = 0` or computes the slippage bound from a pool read. Sandwich-able
   100% of the time.
2. **Unprotected deposit/mint in AMM-like vault.** Same as above, applied to yield vaults.
3. **Missing `deadline` on actions.** A signed permit or a queued transaction with no
   timestamp upper bound can be executed by a validator weeks later at an unfavorable price.
4. **Commit-reveal without enforcement.** `commit`/`reveal` patterns that let the reveal
   transaction choose which commitment to open after seeing everyone else's commits.
5. **Auction that lets winner re-enter on bid placement.** An NFT mint auction where the
   winning bid callback can re-enter `placeBid` and refund itself.
6. **`block.timestamp` / `block.number` as a source of randomness.** A validator picks these.
   Same for `blockhash` — partially miner-influenceable.
7. **Single-block atomic arbitrage profitable at protocol's expense.** Liquidation bots,
   flash-loan-backed trades — not MEV *vulnerabilities* per se, but a protocol that assumes
   sequential-block state is wrong.
8. **Griefing via frontrunning admin calls.** A pending `setFee` becoming observable in the
   mempool lets users rush transactions to avoid the new fee — a design smell, not always a
   bug, but note it.

## Detection heuristics

- Calls to `swap*`, `addLiquidity*`, `removeLiquidity*` where the user's output-min parameter
  is derived on-chain from the pool's own reserves, rather than passed in.
- Router wrappers that hardcode `amountOutMin = 0` or `deadline = type(uint256).max`.
- Any use of `blockhash(n)` / `block.timestamp` / `block.difficulty` (now `prevrandao`) in a
  logic path that awards value.
- Actions that queue for later execution without enforcing a deadline or a commit-reveal gap.

## Recommendation template

> Require the caller to pass an explicit `minAmountOut` and `deadline`; do not derive them
> from pool state. For entropy, use Chainlink VRF or a commit-reveal with a bounded delay.
> Flag MEV-sensitive actions in documentation so integrators use a private relay (Flashbots
> Protect, MEV-Share) when appropriate.

## References

- SWC-114, SWC-116, SWC-120
- Flashbots docs: https://docs.flashbots.net/
- Chainlink VRF: https://docs.chain.link/vrf
