# Curify

Curify is a learning-oriented verified compiler project inspired by [this paper](https://arxiv.org/html/2605.01660v1). The goal is to build a small compiler step by step with Codex,
using Lean to machine-check the key correctness arguments instead of relying on
manual code review alone.

The project is also an experiment in agent-assisted software development:
Codex should complete one small, validated step at a time, commit that step, and
stop for review before continuing.

## Purpose

Curify is meant to teach the process of building a verified compiler from the
ground up:

- define source, intermediate, and target languages as Lean data structures;
- give each language a precise semantics;
- implement compiler passes as ordinary Lean functions;
- prove small pass-correctness theorems and compose them into compiler
  correctness;
- use executable well-formedness checks to make proof assumptions explicit;
- use credible compilation for optimizations, where untrusted optimizers are
  guarded by verified certificate checkers.

## Milestones

Use this checklist to track overall project progress. A milestone should be
checked only after its validation command passes and the corresponding work is
committed.

- [ ] Project scaffold: paper source, project log, glossary, Lean/Lake project,
  and proof-hygiene checks are in place.
- [ ] Lean foundations: names, values, stores, expressions, and basic state
  lemmas are defined and checked.
- [ ] TAC core: operands, straight-line commands, TAC execution, and local TAC
  command lemmas are implemented.
- [ ] AST-to-TAC flattening: integer expressions compile to TAC with a proved
  correctness theorem.
- [ ] Well-formedness and typing: source declarations, reserved-name checks,
  duplicate checks, type checks, and flattening well-formedness preservation are
  proved.
- [ ] Source programs: assignments and straight-line programs compile to TAC
  with observable-state agreement.
- [ ] Modeled errors: execution results include modeled failures such as
  divide-by-zero, and compilation preserves error behavior.
- [ ] Control flow: booleans, conditionals, TAC labels/gotos, and loops have
  semantics and compilation proofs.
- [ ] Credible compilation: TAC certificates, executable checkers, checker
  soundness, and optimization fallback are implemented and proved.
- [ ] Checked optimizations: identity optimization and small examples of
  constant propagation, unreachable-code elimination, common-subexpression
  elimination, dead-assignment elimination, and loop-invariant motion are guarded
  by certificates.
- [ ] ASM target: a minimal target instruction set, machine state, step
  semantics, and TAC-to-ASM code generation are defined.
- [ ] Verified driver: well-formed AST programs compile through the verified
  path, with totality, refinement, and characterization theorems.
- [ ] Language growth: arrays, bounds behavior, and floating-point trust
  boundaries are added deliberately and documented.
- [ ] Text boundaries: parser, AST-direct examples, and ASM pretty printer are
  isolated from the verified core.
- [ ] Validation discipline: executable examples, negative certificate tests,
  and regression tests cover bugs found by testing, checkers, or proofs.
- [ ] Trust and performance review: trusted/untrusted components are documented,
  generated ASM is audited, and checker/compiler hot spots are measured before
  optimization.
- [ ] Final learning deliverables: beginner architecture guide, feature workflow,
  checked-optimization workflow, and final project report are written.

## Working Rule

Every step should be small enough to explain, validate, and commit on its own.
When a theorem is hard, the right response is to inspect the theorem, invariant,
or well-formedness condition, not to weaken the claim or leave an unproved gap.
