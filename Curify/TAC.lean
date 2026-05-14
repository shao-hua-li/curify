import Curify.Store

namespace Curify
namespace TAC

/-!
The first TAC fragment contains shallow operands and straight-line commands.
Commands assign integer constants, copy variables, or add two shallow operands.
Control flow is intentionally left for a later step.
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

/-- Straight-line integer TAC commands, with no labels or jumps yet. -/
inductive Command where
  | assignConst (dest : VarName) (value : IntValue)
  | copy (dest source : VarName)
  | add (dest : VarName) (left right : Operand)
  deriving DecidableEq, Repr

end TAC
end Curify
