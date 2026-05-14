import Curify.Store

namespace Curify

/-!
The first expression fragment has integer literals, variables, and addition.
Evaluation depends on a store, which gives each variable its current value.
-/

/-- Integer expressions in the first Curify source fragment. -/
inductive IntExpr where
  | lit (value : IntValue)
  | var (name : VarName)
  | add (left right : IntExpr)
  deriving DecidableEq, Repr

namespace IntExpr

/-- Evaluate an integer expression in a store. -/
def eval (store : Store) : IntExpr -> IntValue
  | lit value => value
  | var name => store name
  | add left right => eval store left + eval store right

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

/-- Evaluating addition adds the evaluated subexpressions. -/
@[simp]
theorem eval_add (store : Store) (left right : IntExpr) :
    eval store (add left right) = eval store left + eval store right := by
  rfl

end IntExpr
end Curify
