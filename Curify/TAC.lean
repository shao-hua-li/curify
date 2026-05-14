import Curify.Store

namespace Curify
namespace TAC

/-!
The first TAC fragment contains only operands. TAC operands are shallow: each is
either an integer constant or a variable name to read from the store.
-/

/-- Integer TAC operands: constants or variables. -/
inductive Operand where
  | const (value : IntValue)
  | var (name : VarName)
  deriving DecidableEq, Repr

namespace Operand

/-- Evaluate a TAC operand in a store. -/
def eval (store : Store) : Operand -> IntValue
  | const value => value
  | var name => store name

/-- Evaluating a TAC constant returns that constant. -/
@[simp]
theorem eval_const (store : Store) (value : IntValue) :
    eval store (const value) = value := by
  rfl

/-- Evaluating a TAC variable reads the variable from the store. -/
@[simp]
theorem eval_var (store : Store) (name : VarName) :
    eval store (var name) = store name := by
  rfl

end Operand
end TAC
end Curify
