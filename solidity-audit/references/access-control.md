# Access control

Any function that changes privileged state (funds movement, role grants, upgrades, emergency
switches) must restrict who can call it. Getting this wrong ranges from critical (fund theft,
unauthorized minting) to medium (upgrade bypass).

## Patterns and pitfalls

1. **Missing modifier.** Public/external mutating function with no `onlyOwner`, `onlyRole(...)`,
   or equivalent check. Common on `setFee`, `setOracle`, `rescueTokens`, `upgradeTo`.
2. **`tx.origin` auth.** SWC-115. `require(tx.origin == owner)` is defeated by any
   intermediate contract the owner interacts with. Always use `msg.sender`.
3. **Unprotected initializers.** OpenZeppelin upgradeable contracts expose `initialize(...)`.
   Without `initializer` modifier + protection against front-running, an attacker calls
   `initialize` on the implementation contract directly and sets themselves as owner. Also
   applies to proxy beacon contracts.
4. **Role-grant privilege escalation.** `DEFAULT_ADMIN_ROLE` can grant any role; if it is
   mis-assigned (e.g. to a less-trusted multisig), the whole role hierarchy is compromised.
5. **Two-step ownership transfer missing.** Single-step `transferOwnership` to a wrong address
   is unrecoverable. Look for `Ownable2Step` or an explicit pending-owner mechanism.
6. **Delegatecall to untrusted.** `delegatecall` to an address the contract doesn't fully
   control rewrites the caller's storage. Any protocol using external "module" contracts via
   delegatecall must validate the target is on an allowlist.
7. **Self-destruct.** Exposing `SELFDESTRUCT` behind an owner-only function gives owners
   trivial fund theft + makes proxies permanently brick.
8. **Library linking.** Libraries with `delegatecall` that later get re-linked can alter call
   semantics. Parity multi-sig (2017) is the canonical incident.

## Detection heuristics

- Functions whose bodies modify state with no modifier and no `require(...)` at the top.
- Any `tx.origin` usage.
- `initialize(...)` functions in upgradeable contracts without the `initializer` /
  `reinitializer` modifiers, or with missing `_disableInitializers()` in constructor.
- Constructor of an upgradeable contract's implementation that is missing
  `_disableInitializers()`.
- Hardcoded EOA addresses in constructor / setter (often a placeholder the dev meant to
  replace).

## Recommendation template

> Restrict access with an explicit role or owner check. For ownership transitions, use
> OpenZeppelin `Ownable2Step` (pending-owner acceptance) rather than single-step transfer.
> For upgradeable contracts, mark the implementation's constructor with
> `_disableInitializers()` and gate `initialize` with the `initializer` modifier.

## References

- SWC-100, SWC-105, SWC-106, SWC-112, SWC-115, SWC-118
- OpenZeppelin Ownable2Step: https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable2Step
- OZ initializer protection: https://docs.openzeppelin.com/contracts/5.x/upgradeable
