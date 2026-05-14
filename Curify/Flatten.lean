import Curify.Expr
import Curify.TAC

namespace Curify
namespace Flatten

/-!
AST-to-TAC flattening will introduce compiler-generated integer temporaries.
Curify reserves the `__t` prefix for these generated names.
-/

/-- Counter used to choose the next generated temporary name. -/
abbrev TempCounter := Nat

/-- Prefix reserved for generated integer temporaries. -/
def intTempPrefix : String := "__t"

/-- Name of the integer temporary associated with a counter value. -/
def intTempName (counter : TempCounter) : VarName :=
  intTempPrefix ++ toString counter

/-- The initial temporary counter. -/
def firstTemp : TempCounter := 0

/-- Advance to the next temporary counter. -/
def nextTemp (counter : TempCounter) : TempCounter :=
  counter + 1

/-- Compile an integer literal into a TAC assignment to `dest`. -/
def compileIntLiteral (dest : VarName) (value : IntValue) : TAC.Program :=
  [TAC.Command.assignConst dest value]

/--
Executing the TAC for an integer literal stores the expression value in the
requested destination.
-/
theorem compileIntLiteral_correct
    (store : Store) (dest : VarName) (value : IntValue) :
    TAC.Program.exec (compileIntLiteral dest value) store dest =
      IntExpr.eval store (IntExpr.lit value) := by
  simp [compileIntLiteral]

/-- Compile an integer variable into a TAC copy to `dest`. -/
def compileIntVariable (dest source : VarName) : TAC.Program :=
  [TAC.Command.copy dest source]

/--
Executing the TAC for an integer variable stores the expression value in the
requested destination.
-/
theorem compileIntVariable_correct
    (store : Store) (dest source : VarName) :
    TAC.Program.exec (compileIntVariable dest source) store dest =
      IntExpr.eval store (IntExpr.var source) := by
  simp [compileIntVariable]

end Flatten
end Curify
