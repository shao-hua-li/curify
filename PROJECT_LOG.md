# Curify Project Log

This log records each completed Curify step. Keep entries small and factual so
future proof work can recover why a design choice or validation check was added.

| Step | Date | Commit | Concept learned | Validation |
| --- | --- | --- | --- | --- |
| Track Axon paper source | 2026-05-14 | `7f02820` | The paper is the project specification, so verified work needs a pinned source. | `git diff --check --cached` passed |
| Initialize Lean/Lake project | 2026-05-14 | This commit | Lean code is organized into modules, and Lake checks the first theorem. | `lake build` passed |
| Add proof hygiene check | 2026-05-14 | This commit | Completed proof steps should mechanically reject unapproved proof escapes. | `scripts/check-proof-hygiene.sh` and `lake build` passed |
| Define names and integer values | 2026-05-14 | This commit | `abbrev` gives compiler concepts readable names before syntax and semantics. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define integer store | 2026-05-14 | This commit | Functions can model maps, and update lemmas make later state proofs reusable. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define integer literals | 2026-05-14 | This commit | An AST can be an inductive datatype, and semantics can be a total evaluator. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Add integer variables | 2026-05-14 | This commit | Source expression semantics can depend on program state through a store. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Add integer addition | 2026-05-14 | This commit | Recursive AST syntax leads to recursive evaluators and local evaluation facts. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define TAC operands | 2026-05-14 | This commit | TAC operands are shallow constants or variable reads over the store. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define straight-line TAC commands | 2026-05-14 | This commit | TAC commands make each assignment, copy, and addition explicit before control flow. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define straight-line TAC semantics | 2026-05-14 | This commit | Executable semantics can model command and program execution as store transformations. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Add TAC command destination lemmas | 2026-05-14 | This commit | Small command lemmas keep later compiler proofs readable and reusable. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
| Define temporary names | 2026-05-14 | This commit | Flattening needs reserved generated names and a counter for fresh temporaries. | `lake build` and `scripts/check-proof-hygiene.sh` passed |
