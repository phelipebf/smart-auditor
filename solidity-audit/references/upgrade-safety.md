# Upgrade safety

Proxied / upgradeable contracts (Transparent Proxy, UUPS, Beacon) split code and storage. The
code can change; the storage layout must not. Mistakes here can brick the protocol or silently
corrupt user balances.

## Patterns and pitfalls

1. **Storage layout change between versions.** Adding a state variable in the middle of the
   existing layout (rather than at the end) shifts every subsequent variable's slot, silently
   mixing values between them.
2. **Inheritance order change between versions.** Adding/removing/reordering parent contracts
   shifts slots in an equally silent way.
3. **Missing storage gaps.** OpenZeppelin's upgradeable base contracts reserve `__gap` slots
   for future fields. A derived contract without its own gap can't safely add state later.
4. **Uninitialized implementation.** UUPS implementation with an `initialize(...)` that lacks
   the `initializer` modifier — anyone can call it on the implementation directly and
   become owner. Partial mitigation: constructor calls `_disableInitializers()`.
5. **Missing access control on `_authorizeUpgrade`.** UUPS proxies delegate upgrade authority
   to the implementation via `_authorizeUpgrade`. Forgetting to restrict it (by `onlyOwner`
   or role) means anyone can upgrade.
6. **Constructor-initialized state.** Constructor-set `immutable` or storage variables are
   evaluated in the implementation's deployment context, not the proxy's. Use `initialize`
   for all storage writes.
7. **Selector clash (Transparent Proxy).** A function on the implementation with the same
   4-byte selector as a proxy admin function (e.g. `upgradeTo`). Calls from the admin hit the
   proxy, calls from others hit the implementation — mismatch between expected and actual
   behavior. Less of an issue in modern TransparentUpgradeableProxy (admin is a separate
   contract) but still worth checking.
8. **Non-deterministic storage via Diamonds.** EIP-2535 diamonds use `DiamondStorage` with
   hashed slots. Getting the hash wrong, or colliding slots across facets, corrupts state.

## Detection heuristics

- Any `initialize(...)` missing the `initializer` / `reinitializer(v)` modifier.
- Any upgradeable contract whose constructor does **not** call `_disableInitializers()`.
- UUPS implementation missing `_authorizeUpgrade(address)` or with an empty body.
- New version of a contract that adds a state variable in the middle of declarations (compare
  against the previous version if present in the repo).
- Derived upgradeable contracts without a `uint256[__N__] private __gap;` at the end.
- Constructor code that writes to non-immutable storage on an upgradeable contract.

## Recommendation template

> Use OpenZeppelin Upgrades plugin (`@openzeppelin/contracts-upgradeable` + Hardhat/Foundry
> plugin) to validate storage layout between versions. Add a `__gap` array to every
> upgradeable contract. Protect `initialize` with the `initializer` modifier and disable
> initializers in the implementation's constructor. For UUPS, gate `_authorizeUpgrade` on
> `onlyOwner` or a dedicated upgrade role.

## References

- OZ Upgrades: https://docs.openzeppelin.com/upgrades-plugins/
- EIP-1967 (Transparent Proxy storage slots): https://eips.ethereum.org/EIPS/eip-1967
- EIP-1822 (UUPS): https://eips.ethereum.org/EIPS/eip-1822
- EIP-2535 (Diamonds): https://eips.ethereum.org/EIPS/eip-2535
