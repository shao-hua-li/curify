# Curify Glossary

This glossary gives beginner definitions for the first compiler and proof terms
used in Curify. The definitions are intentionally small; we will refine them as
the Lean development makes each idea concrete.

## Compiler Terms

**AST**: Abstract syntax tree. Curify's source program representation after
parsing, or after constructing a program directly as Lean data.

**TAC**: Three-address code. Curify's intermediate representation, where nested
source expressions are flattened into simple commands over variables,
temporaries, and constants.

**ASM**: Assembly representation. Curify's target language model, limited to
the instructions the compiler actually emits.

**Semantics**: A precise meaning for a language. In Curify this will usually be
a Lean definition that says what evaluating an expression or running a program
does.

**State**: The information a running program can read or update, such as the
current values stored for variables.

**Well-formedness**: A set of checks that rules out programs the verified
compiler is not designed to compile, such as duplicate declarations or reserved
temporary names.

**Type context**: A record of the type assigned to each variable, temporary, or
register. It lets later compiler phases preserve typing information.

## Lean And Proof Terms

**Proposition**: A statement that can be proved in Lean. Compiler correctness
claims are written as propositions.

**Theorem**: A named proposition together with a Lean proof. A completed theorem
is machine-checked evidence that the statement follows from the definitions.

**Lemma**: A theorem used as a smaller helper proof. Lemmas keep larger compiler
correctness proofs understandable and reusable.

**Executable check**: A Lean function that computes `true` or `false`, such as a
well-formedness check used by the compiler driver.

## Correctness Terms

**Refinement**: A correctness relation saying that each behavior of generated
target code is matched by an allowed behavior of the source program.

**Characterization**: A correctness statement saying generated target code has
only the expected kinds of behavior, such as normal halt, modeled error, or
divergence.

**Totality**: A correctness statement saying every well-formed source program
successfully compiles to target code.

## Certificate Terms

**Certificate**: Extra evidence produced alongside an unverified transformation,
such as an optimization, to justify that the result is acceptable.

**Checker**: Verified code that inspects a certificate and rejects transformed
code unless the certificate establishes the required properties.

**Trusted computing base**: The parts of the system that must be trusted rather
than proved inside Curify, such as the Lean kernel, compiler runtime, operating
system, and any explicitly unverified boundaries.
