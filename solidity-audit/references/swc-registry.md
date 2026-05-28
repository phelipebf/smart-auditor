# SWC Registry — quick cross-reference

The SWC (Smart Contract Weakness Classification) registry is the canonical taxonomy of EVM
smart-contract weaknesses. Use these IDs in the `references` field of findings when the
category fits, alongside a link to `https://swcregistry.io/docs/SWC-###`.

| SWC | Title | Map to category |
|---|---|---|
| SWC-100 | Function Default Visibility | `access-control` |
| SWC-101 | Integer Overflow and Underflow | `arithmetic` |
| SWC-102 | Outdated Compiler Version | `upgrade-safety` |
| SWC-103 | Floating Pragma | `upgrade-safety` |
| SWC-104 | Unchecked Call Return Value | `access-control` |
| SWC-105 | Unprotected Ether Withdrawal | `access-control` |
| SWC-106 | Unprotected SELFDESTRUCT | `access-control` |
| SWC-107 | Reentrancy | `reentrancy` |
| SWC-108 | State Variable Default Visibility | `access-control` |
| SWC-109 | Uninitialized Storage Pointer | `arithmetic` |
| SWC-110 | Assert Violation | `arithmetic` |
| SWC-111 | Use of Deprecated Functions | `upgrade-safety` |
| SWC-112 | Delegatecall to Untrusted Callee | `access-control` |
| SWC-113 | DoS with Failed Call | `mev` |
| SWC-114 | Transaction Order Dependence | `mev` |
| SWC-115 | `tx.origin` Authentication | `access-control` |
| SWC-116 | Block values as a proxy for time | `mev` |
| SWC-117 | Signature Malleability | `access-control` |
| SWC-118 | Incorrect Constructor Name | `access-control` |
| SWC-119 | Shadowing State Variables | `upgrade-safety` |
| SWC-120 | Weak Randomness (blockhash, timestamp) | `mev` |
| SWC-121 | Missing Protection against Signature Replay | `access-control` |
| SWC-122 | Lack of Proper Signature Verification | `access-control` |
| SWC-123 | Requirement Violation | `arithmetic` |
| SWC-124 | Write to Arbitrary Storage | `upgrade-safety` |
| SWC-125 | Incorrect Inheritance Order | `upgrade-safety` |
| SWC-126 | Insufficient Gas Griefing | `mev` |
| SWC-127 | Arbitrary Jump with Function Type | `access-control` |
| SWC-128 | DoS With Block Gas Limit | `mev` |
| SWC-129 | Typographical Error | `arithmetic` |
| SWC-130 | Right-To-Left-Override control character (U+202E) | `informational` |
| SWC-131 | Presence of unused variables | `informational` |
| SWC-132 | Unexpected Ether balance | `arithmetic` |
| SWC-133 | Hash Collisions With Multiple Variable Length Arguments | `access-control` |
| SWC-134 | Message call with hardcoded gas amount | `mev` |
| SWC-135 | Code With No Effects | `informational` |
| SWC-136 | Unencrypted Private Data On-Chain | `informational` |

Always include the full URL, e.g. `https://swcregistry.io/docs/SWC-107`.
