import Curify.Core

namespace Curify

/-!
The first expression fragment has only integer literals. This is the smallest
AST that can already have a meaningful evaluator.
-/

/-- Integer expressions in the first Curify source fragment. -/
inductive IntExpr where
  | lit (value : IntValue)
  deriving DecidableEq, Repr

namespace IntExpr

/-- Evaluate an integer expression to its integer value. -/
def eval : IntExpr -> IntValue
  | lit value => value

/-- Evaluating an integer literal returns that literal's value. -/
@[simp]
theorem eval_lit (value : IntValue) :
    eval (lit value) = value := by
  rfl

end IntExpr
end Curify
