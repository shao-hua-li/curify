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

namespace Command

/-- Execute one TAC command by updating the store. -/
def exec (command : Command) (store : Store) : Store :=
  match command with
  | assignConst dest value => Store.update store dest value
  | copy dest source => Store.update store dest (store source)
  | add dest left right =>
      Store.update store dest (Operand.eval store left + Operand.eval store right)

end Command

/-- A straight-line TAC program is a list of commands. -/
abbrev Program := List Command

namespace Program

/-- Execute a straight-line TAC program from left to right. -/
def exec : Program -> Store -> Store
  | [], store => store
  | command :: rest, store => exec rest (Command.exec command store)

/-- Executing an empty TAC program leaves the store unchanged. -/
@[simp]
theorem exec_nil (store : Store) :
    exec [] store = store := by
  rfl

/-- Executing a cons runs the first command, then the rest of the program. -/
@[simp]
theorem exec_cons (command : Command) (rest : Program) (store : Store) :
    exec (command :: rest) store = exec rest (Command.exec command store) := by
  rfl

end Program
end TAC
end Curify
