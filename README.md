<h1 align="center">Smart Auditor</h1>

<p align="center">
  <a href="https://blockammo.io/">
    <img src="static/logo-blockammo-no-text.png" alt="blockammo" width="120">
  </a>
</p>

<p align="center">
  <b style="font-size: 20">An collection of AI agent skills for smart contracts auditing</b>
</p>
<p align="center">
  <a href="https://github.com/phelipebf/smart-auditor/issues/new/choose"><img alt="Issues" title="Issues" src="https://img.shields.io/github/issues-raw/phelipebf/smart-auditor"></a>
  <img alt="phelipebf GitHub repo size" title="phelipebf GitHub repo size" src="https://img.shields.io/github/languages/code-size/phelipebf/smart-auditor">
  <img alt="phelipebf GitHub commit activity" title="phelipebf GitHub commit activity" src="https://img.shields.io/github/commit-activity/t/phelipebf/smart-auditor">
  <img alt="GitHub last commit" title="GitHub last commit" src="https://img.shields.io/github/last-commit/phelipebf/smart-auditor">
  <a href="https://github.com/phelipebf/smart-auditor/actions/workflows/skill-warden.yml"><img alt="skill-warden" title="skill-warden" src="https://github.com/phelipebf/smart-auditor/actions/workflows/skill-warden.yml/badge.svg"></a>
</p>

<p align="center">
  <b>Supported AI Platforms</b>
</p>
<p align="center">
  <a href="https://claude.ai/download"><img alt="Claude Code" title="Claude Code" src="https://img.shields.io/badge/Claude_Code-F5E6D0?style=for-the-badge&logo=anthropic&logoColor=1a1a1a"></a>
  <a href="https://cursor.com"><img alt="Cursor" title="Cursor" src="https://img.shields.io/badge/Cursor-000000?style=for-the-badge&logo=cursor&logoColor=white"></a>
  <a href="https://openai.com/codex/"><img alt="Codex" title="Codex" src="https://img.shields.io/badge/Codex-000000?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyByb2xlPSJpbWciIHZpZXdCb3g9IjAgMCAyNCAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBmaWxsPSJ3aGl0ZSIgZD0iTTIyLjI4MTkgOS44MjExYTUuOTg0NyA1Ljk4NDcgMCAwIDAtLjUxNTctNC45MTA4IDYuMDQ2MiA2LjA0NjIgMCAwIDAtNi41MDk4LTIuOUE2LjA2NTEgNi4wNjUxIDAgMCAwIDQuOTgwNyA0LjE4MThhNS45ODQ3IDUuOTg0NyAwIDAgMC0zLjk5NzcgMi45IDYuMDQ2MiA2LjA0NjIgMCAwIDAgLjc0MjcgNy4wOTY2IDUuOTggNS45OCAwIDAgMCAuNTExIDQuOTEwNyA2LjA1MSA2LjA1MSAwIDAgMCA2LjUxNDYgMi45MDAxQTUuOTg0NyA1Ljk4NDcgMCAwIDAgMTMuMjU5OSAyNGE2LjA1NTcgNi4wNTU3IDAgMCAwIDUuNzcxOC00LjIwNTggNS45ODk0IDUuOTg5NCAwIDAgMCAzLjk5NzctMi45MDAxIDYuMDU1NyA2LjA1NTcgMCAwIDAtLjc0NzUtNy4wNzI5em0tOS4wMjIgMTIuNjA4MWE0LjQ3NTUgNC40NzU1IDAgMCAxLTIuODc2NC0xLjA0MDhsLjE0MTktLjA4MDQgNC43NzgzLTIuNzU4MmEuNzk0OC43OTQ4IDAgMCAwIC4zOTI3LS42ODEzdi02LjczNjlsMi4wMiAxLjE2ODZhLjA3MS4wNzEgMCAwIDEgLjAzOC4wNTJ2NS41ODI2YTQuNTA0IDQuNTA0IDAgMCAxLTQuNDk0NSA0LjQ5NDR6bS05LjY2MDctNC4xMjU0YTQuNDcwOCA0LjQ3MDggMCAwIDEtLjUzNDYtMy4wMTM3bC4xNDIuMDg1MiA0Ljc4MyAyLjc1ODJhLjc3MTIuNzcxMiAwIDAgMCAuNzgwNiAwbDUuODQyOC0zLjM2ODV2Mi4zMzI0YS4wODA0LjA4MDQgMCAwIDEtLjAzMzIuMDYxNUw5Ljc0IDE5Ljk1MDJhNC40OTkyIDQuNDk5MiAwIDAgMS02LjE0MDgtMS42NDY0ek0yLjM0MDggNy44OTU2YTQuNDg1IDQuNDg1IDAgMCAxIDIuMzY1NS0xLjk3MjhWMTEuNmEuNzY2NC43NjY0IDAgMCAwIC4zODc5LjY3NjVsNS44MTQ0IDMuMzU0My0yLjAyMDEgMS4xNjg1YS4wNzU3LjA3NTcgMCAwIDEtLjA3MSAwbC00LjgzMDMtMi43ODY1QTQuNTA0IDQuNTA0IDAgMCAxIDIuMzQwOCA3Ljg3MnptMTYuNTk2MyAzLjg1NThMMTMuMTAzOCA4LjM2NCAxNS4xMTkyIDcuMmEuMDc1Ny4wNzU3IDAgMCAxIC4wNzEgMGw0LjgzMDMgMi43OTEzYTQuNDk0NCA0LjQ5NDQgMCAwIDEtLjY3NjUgOC4xMDQydi01LjY3NzJhLjc5Ljc5IDAgMCAwLS40MDctLjY2N3ptMi4wMTA3LTMuMDIzMWwtLjE0Mi0uMDg1Mi00Ljc3MzUtMi43ODE4YS43NzU5Ljc3NTkgMCAwIDAtLjc4NTQgMEw5LjQwOSA5LjIyOTdWNi44OTc0YS4wNjYyLjA2NjIgMCAwIDEgLjAyODQtLjA2MTVsNC44MzAzLTIuNzg2NmE0LjQ5OTIgNC40OTkyIDAgMCAxIDYuNjgwMiA0LjY2ek04LjMwNjUgMTIuODYzbC0yLjAyLTEuMTYzOGEuMDgwNC4wODA0IDAgMCAxLS4wMzgtLjA1NjdWNi4wNzQyYTQuNDk5MiA0LjQ5OTIgMCAwIDEgNy4zNzU3LTMuNDUzN2wtLjE0Mi4wODA1TDguNzA0IDUuNDU5YS43OTQ4Ljc5NDggMCAwIDAtLjM5MjcuNjgxM3ptMS4wOTc2LTIuMzY1NGwyLjYwMi0xLjQ5OTggMi42MDY5IDEuNDk5OHYyLjk5OTRsLTIuNTk3NCAxLjQ5OTctMi42MDY3LTEuNDk5N1oiLz48L3N2Zz4=&logoColor=white"></a>
  <a href="https://github.com/features/copilot"><img alt="GitHub Copilot" title="GitHub Copilot" src="https://img.shields.io/badge/GitHub_Copilot-000000?style=for-the-badge&logo=githubcopilot&logoColor=white"></a>
  <a href="https://geminicli.com/"><img alt="Gemini CLI" title="Gemini CLI" src="https://img.shields.io/badge/Gemini_cli-blue?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxnIGNsaXAtcGF0aD0idXJsKCNjbGlwMF8yNTM1XzE2NykiPgo8bWFzayBpZD0ibWFzazBfMjUzNV8xNjciIHN0eWxlPSJtYXNrLXR5cGU6bHVtaW5hbmNlIiBtYXNrVW5pdHM9InVzZXJTcGFjZU9uVXNlIiB4PSIwIiB5PSIwIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiI+CjxwYXRoIGQ9Ik00MTguNTY5IDBIOTMuNDMwOEM0MS44MzA0IDAgMCA0MS44MzA0IDAgOTMuNDMwOFY0MTguNTY5QzAgNDcwLjE3IDQxLjgzMDQgNTEyIDkzLjQzMDggNTEySDQxOC41NjlDNDcwLjE3IDUxMiA1MTIgNDcwLjE3IDUxMiA0MTguNTY5VjkzLjQzMDhDNTEyIDQxLjgzMDQgNDcwLjE3IDAgNDE4LjU2OSAwWiIgZmlsbD0id2hpdGUiLz4KPC9tYXNrPgo8ZyBtYXNrPSJ1cmwoI21hc2swXzI1MzVfMTY3KSI+CjxwYXRoIGQ9Ik00MTkuNzc2IDAuMDA3ODEyNDhDNDcwLjgyIDAuNjU0NTkyIDUxMiA0Mi4yMzMyIDUxMiA5My40Mjk2VjQxOC41NzJMNTExLjk5MiA0MTkuNzc2QzUxMS4zNDQgNDcwLjgyIDQ2OS43NjggNTEyIDQxOC41NzIgNTEySDkzLjQyOTZDNDEuODMgNTEyIDAuMDAwNTI1NzQgNDcwLjE2OCAwIDQxOC41NzJWOTMuNDI5NkMwLjAwMDUyMzI0OCA0Mi4yMzMyIDQxLjE3OTIgMC42NTQ1OTYgOTIuMjIyOCAwLjAwNzgxMjQ4TDkzLjQyOTYgMEg0MTguNTcyTDQxOS43NzYgMC4wMDc4MTI0OFpNOTMuNDI5NiAyOS44OTg0QzU4LjM0MjQgMjkuODk5IDI5Ljg5OSA1OC4zNDI0IDI5Ljg5ODQgOTMuNDI5NlY0MTguNTcyQzI5Ljg5OSA0NTMuNjU2IDU4LjM0MjQgNDgyLjEgOTMuNDI5NiA0ODIuMUg0MTguNTcyQzQ1My42NTYgNDgyLjEgNDgyLjEgNDUzLjY1NiA0ODIuMSA0MTguNTcyVjkzLjQyOTZDNDgyLjEgNTguMzQyNCA0NTMuNjU2IDI5Ljg5OSA0MTguNTcyIDI5Ljg5ODRIOTMuNDI5NlpNMzU3LjkyNiAyMjMuMTI5VjMwMS4yNzRMMTU0Ljc1NCAzOTguOTQ5VjM0Mi4yOTdMMzIxLjE5OSAyNjIuMTk5TDE1NC43NTQgMTgyLjEwNlYxMjUuNDUzTDM1Ny45MjYgMjIzLjEyOVoiIGZpbGw9InVybCgjcGFpbnQwX2xpbmVhcl8yNTM1XzE2NykiLz4KPHBhdGggZD0iTTQxOS43NzYgMC4wMDc4MTI0OEM0NzAuODIgMC42NTQ1OTIgNTEyIDQyLjIzMzIgNTEyIDkzLjQyOTZWNDE4LjU3Mkw1MTEuOTkyIDQxOS43NzZDNTExLjM0NCA0NzAuODIgNDY5Ljc2OCA1MTIgNDE4LjU3MiA1MTJIOTMuNDI5NkM0MS44MyA1MTIgMC4wMDA1MjU3NCA0NzAuMTY4IDAgNDE4LjU3MlY5My40Mjk2QzAuMDAwNTIzMjQ4IDQyLjIzMzIgNDEuMTc5MiAwLjY1NDU5NiA5Mi4yMjI4IDAuMDA3ODEyNDhMOTMuNDI5NiAwSDQxOC41NzJMNDE5Ljc3NiAwLjAwNzgxMjQ4Wk05My40Mjk2IDI5Ljg5ODRDNTguMzQyNCAyOS44OTkgMjkuODk5IDU4LjM0MjQgMjkuODk4NCA5My40Mjk2VjQxOC41NzJDMjkuODk5IDQ1My42NTYgNTguMzQyNCA0ODIuMSA5My40Mjk2IDQ4Mi4xSDQxOC41NzJDNDUzLjY1NiA0ODIuMSA0ODIuMSA0NTMuNjU2IDQ4Mi4xIDQxOC41NzJWOTMuNDI5NkM0ODIuMSA1OC4zNDI0IDQ1My42NTYgMjkuODk5IDQxOC41NzIgMjkuODk4NEg5My40Mjk2Wk0zNTcuOTI2IDIyMy4xMjlWMzAxLjI3NEwxNTQuNzU0IDM5OC45NDlWMzQyLjI5N0wzMjEuMTk5IDI2Mi4xOTlMMTU0Ljc1NCAxODIuMTA2VjEyNS40NTNMMzU3LjkyNiAyMjMuMTI5WiIgZmlsbD0iI0UzRTNFMyIvPgo8L2c+CjwvZz4KPGRlZnM+CjxsaW5lYXJHcmFkaWVudCBpZD0icGFpbnQwX2xpbmVhcl8yNTM1XzE2NyIgeDE9IjExOS41OTEiIHkxPSIyNTcuODY5IiB4Mj0iMzkzLjM0MyIgeTI9IjI1Ny44NjkiIGdyYWRpZW50VW5pdHM9InVzZXJTcGFjZU9uVXNlIj4KPHN0b3Agb2Zmc2V0PSIwLjAxOTYyOTIiIHN0b3AtY29sb3I9IiM0MDZBRkIiLz4KPHN0b3Agb2Zmc2V0PSIwLjIyNjgyNyIgc3RvcC1jb2xvcj0iIzA3OEVGQiIvPgo8c3RvcCBvZmZzZXQ9IjAuNDE4NzU3IiBzdG9wLWNvbG9yPSIjOTM5QUZGIi8+CjxzdG9wIG9mZnNldD0iMC41ODQ1MTUiIHN0b3AtY29sb3I9IiNENjk4RkMiLz4KPHN0b3Agb2Zmc2V0PSIwLjc3NDI2NCIgc3RvcC1jb2xvcj0iI0ZBNjE3OCIvPgo8c3RvcCBvZmZzZXQ9IjAuOTc5MjgiIHN0b3AtY29sb3I9IiNGMjU1NEYiLz4KPC9saW5lYXJHcmFkaWVudD4KPGNsaXBQYXRoIGlkPSJjbGlwMF8yNTM1XzE2NyI+CjxyZWN0IHdpZHRoPSI1MTIiIGhlaWdodD0iNTEyIiBmaWxsPSJ3aGl0ZSIvPgo8L2NsaXBQYXRoPgo8L2RlZnM+Cjwvc3ZnPgo=&logoColor=white"></a>
  <a href="https://www.windsurf.com/"><img alt="Windsurf" title="Windsurf" src="https://img.shields.io/badge/Windsurf-0062FF?style=for-the-badge&logo=windsurf&logoColor=white"></a>
</p>

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/phelipebf/smart-auditor/main/install.sh | bash
```

- The installer will prompt for your agent and install location:
  - **Global** - skills installed to `~/.claude/skills/`
  - **Current project** - skills installed to `.claude/skills/`
- Next time you are auditing with an AI agent, the agent will automatically know when to read the skill files and invoke it.

<br>

## Skills

Each subdirectory is a self-contained skill with a `SKILL.md` describing when it should be invoked, its workflow, and the artifacts it produces. Drop a skill into your agent skills directory (or symlink it) and the agent will load it when the trigger conditions match.

| Skill | Stack | Status |
|---|---|---|
| [`solidity-audit/`](./solidity-audit) | Solidity / EVM | v0.1.0 |

### `solidity-audit`

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

##

<p align="center">
  <b>Built by</b>
</p>
<p align="center">
  <a href="https://blockammo.io/"><img alt="Blockammo" title="Blockammo" height="35" src="static/logo-blockammo.png"></a>
</p>
