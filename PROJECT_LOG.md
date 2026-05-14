# Curify Project Log

This log records each completed Curify step. Keep entries small and factual so
future proof work can recover why a design choice or validation check was added.

| Step | Date | Commit | Concept learned | Validation |
| --- | --- | --- | --- | --- |
| Track Axon paper source | 2026-05-14 | `7f02820` | The paper is the project specification, so verified work needs a pinned source. | `git diff --check --cached` passed |
| Initialize Lean/Lake project | 2026-05-14 | This commit | Lean code is organized into modules, and Lake checks the first theorem. | `lake build` passed |
| Add proof hygiene check | 2026-05-14 | This commit | Completed proof steps should mechanically reject unapproved proof escapes. | `scripts/check-proof-hygiene.sh` and `lake build` passed |
