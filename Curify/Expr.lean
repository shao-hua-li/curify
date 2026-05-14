import Curify.Store

namespace Curify

/-!
The first expression fragment has integer literals and variables. Evaluation now
depends on a store, which gives each variable its current value.
-/

/-- Integer expressions in the first Curify source fragment. -/
inductive IntExpr where
  | lit (value : IntValue)
  | var (name : VarName)
  deriving DecidableEq, Repr

namespace IntExpr

/-- Evaluate an integer expression in a store. -/
def eval (store : Store) : IntExpr -> IntValue
  | lit value => value
  | var name => store name

/-- Evaluating an integer literal returns that literal's value. -/
@[simp]
theorem eval_lit (store : Store) (value : IntValue) :
    eval store (lit value) = value := by
  rfl

/-- Evaluating a variable reads its current value from the store. -/
@[simp]
theorem eval_var (store : Store) (name : VarName) :
    eval store (var name) = store name := by
  rfl

end IntExpr
end Curify
