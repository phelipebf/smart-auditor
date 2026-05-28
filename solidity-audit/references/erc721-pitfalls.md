# ERC-721 pitfalls

NFT contracts have their own class of bugs, mostly around callback-based transfer flow and
metadata assumptions.

## Patterns and pitfalls

1. **`_safeMint` reentrancy.** `_safeMint(to, id)` calls `onERC721Received(...)` on the
   recipient if it is a contract. If minted state is written *after* the call (or if a
   counter is incremented after), the recipient can re-enter `_safeMint` and mint more than
   the cap. Mint functions that mint in a loop via `_safeMint` are particularly prone.
2. **`_safeTransferFrom` reentrancy.** Same callback, same issue. CEI applies.
3. **Missing `_safeMint` support for contract recipients.** Using `_mint` instead of
   `_safeMint` — contracts that can't handle NFTs (no `onERC721Received`) permanently lose the
   token. Tradeoff with (1); choose `_safeMint` + reentrancy guard.
4. **tokenURI assumptions.** Protocols that index by `tokenURI(id)` break on collections that
   change URIs post-mint (revealing / reveals, upgrade). Also: base-URI concatenation can
   produce `ipfs://bafy.../0` vs `ipfs://bafy.../00000` — leading-zero sensitivity.
5. **Owner check via `ownerOf(id) == msg.sender`.** Works, but doesn't handle approved
   operators. If an action is meant to be usable by operators too, use `_isAuthorized`
   / `isApprovedForAll`.
6. **Burn gaps.** OZ `_burn(id)` clears the owner mapping; some custom implementations do
   not, leaving `ownerOf` returning the previous owner after burn.
7. **ERC-1155 batch reentrancy.** `safeBatchTransferFrom` calls `onERC1155BatchReceived` —
   same reentrancy surface as 721, but amplified because it transfers multiple ids at once.
8. **Royalty (EIP-2981) assumptions.** Treating `royaltyInfo` as enforceable on-chain is
   wrong — it's a hint. Marketplaces choose whether to honor it.
9. **Enumeration cost.** `ERC721Enumerable`'s `tokensOfOwner` is O(n) on-chain. Calling it
   from another contract is a gas bomb.

## Detection heuristics

- Mint functions calling `_safeMint` inside a loop before incrementing the cap/counter.
- Transfer functions with external calls after state is read but before it is written.
- Any use of `_mint(to, id)` where `to` could be a contract (check for `isContract` gate or
  `_safeMint` alternative).
- Owner-gated actions that check `ownerOf(id) == msg.sender` but should accept operator
  approvals.

## Recommendation template

> Use `_safeMint` / `_safeTransferFrom` but wrap mint-loop functions with `nonReentrant`.
> Apply Checks-Effects-Interactions: finalize all state (counters, balances, mappings)
> before the external callback.

## References

- EIP-721: https://eips.ethereum.org/EIPS/eip-721
- EIP-1155: https://eips.ethereum.org/EIPS/eip-1155
- OZ ERC721: https://docs.openzeppelin.com/contracts/5.x/erc721
