<h1 align="center">Smart Auditor</h1>

<!-- <p align="center">
  <img src="static/logo.svg" alt="pocer" width="180">
</p> -->

<p align="center">
 <b>An collection of AI agent skills for smart contracts auditing</b>
</p>
<p align="center">
  <a href="https://github.com/phelipebf/smart-auditor/issues/new/choose"><img alt="Issues" title="Issues" src="https://img.shields.io/github/issues-raw/phelipebf/smart-auditor"></a>
  <img alt="phelipebf GitHub repo size" title="phelipebf GitHub repo size" src="https://img.shields.io/github/languages/code-size/phelipebf/smart-auditor">
  <img alt="phelipebf GitHub commit activity" title="phelipebf GitHub commit activity" src="https://img.shields.io/github/commit-activity/t/phelipebf/smart-auditor">
  <img alt="GitHub last commit" title="GitHub last commit" src="https://img.shields.io/github/last-commit/phelipebf/smart-auditor">
  <a href="https://github.com/phelipebf/smart-auditor/actions/workflows/skill-warden.yml"><img alt="skill-warden" title="skill-warden" src="https://github.com/phelipebf/smart-auditor/actions/workflows/skill-warden.yml/badge.svg"></a>
</p>

AI Agents skills for auditing smart contracts.

Each subdirectory is a self-contained skill with a `SKILL.md` describing when it should be invoked, its workflow, and the artifacts it produces. Drop a skill into your agent skills directory (or symlink it) and the agent will load it when the trigger conditions match.

## Skills

| Skill | Stack | Status |
|---|---|---|
| [`solidity-audit/`](./solidity-audit) | Solidity / EVM | v0.1.0 |

## `solidity-audit`

Audits Solidity / EVM smart contracts for:

- Reentrancy (classic, cross-function, read-only, ERC-777/1155 callbacks)
- Access control (missing modifiers, unprotected initializers)
- Arithmetic (over/underflow, precision loss, rounding direction)
- Oracle manipulation (spot prices, stale data, single-source)
- MEV / front-running (missing deadlines, sandwichable trades)
- Upgrade safety (storage layout, selector clashes)
- ERC-20 / ERC-721 integration pitfalls

The skill is triggered automatically when the working directory contains `*.sol` files or a Hardhat / Foundry / Truffle config. It builds on Slither and Aderyn output when present (`audit-output/slither.json`, `audit-output/aderyn.json`) and otherwise falls back to direct source review.

### Prerequisites (if want to ingest data from static analysis)

```bash
pip3 install slither-analyzer
cargo install aderyn
```

### Inputs / outputs

Reads from the project root and (optionally) `audit-output/slither.json` and `audit-output/aderyn.json`. Writes:

- [`audit-output/findings.json`](./solidity-audit/templates/findings-schema.json) — array of findings validated against the schema
- `audit-output/summary.json` — counts by severity, frameworks detected, Solidity version range, LOC

Findings use Code4rena-aligned severities (`Critical` / `High` / `Medium` / `Low` / `Informational`) and are tagged with `source` (`static-analysis` / `manual-review` / `both`).

### Safety rules

The skill never executes contracts, never modifies source files, and treats all in-repo text (including comments and NatSpec) as untrusted data. Prompt-injection attempts inside source code are logged as findings rather than followed.

See [`solidity-audit/SKILL.md`](./solidity-audit/SKILL.md) for the full workflow, gotchas, and examples.

## Layout

```
solidity-audit/
├── SKILL.md                 # entry point agent loads
├── references/              # category-specific reference notes loaded on demand
│   ├── reentrancy.md
│   ├── access-control.md
│   ├── arithmetic.md
│   ├── oracle-manipulation.md
│   ├── mev.md
│   ├── upgrade-safety.md
│   ├── erc20-pitfalls.md
│   ├── erc721-pitfalls.md
│   └── swc-registry.md
├── templates/
│   └── findings-schema.json # JSON Schema for audit-output/findings.json
└── evals/
    └── fixtures/vuln/       # vulnerable fixtures + expected findings for regression
```

## Usage

Invoke from any Solidity project:

```
You are performing a security audit on the smart contract codebase in the current
working directory. Use the `solidity-audit` skill to guide your work.
```

The agent will enumerate in-scope contracts, ingest analyzer output if present, perform a per-contract semantic review against the reference notes, and emit the two JSON artifacts under `audit-output/`.
