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

/--
Compile an integer addition from already-flattened subexpression code.

The left code must store its result in `__t<counter>`, and the right code must
store its result in `__t<counter+1>`.
-/
def compileIntAddition
    (dest : VarName) (counter : TempCounter)
    (leftCode rightCode : TAC.Program) : TAC.Program :=
  let leftTemp := intTempName counter
  let rightTemp := intTempName (nextTemp counter)
  leftCode ++ rightCode ++
    [TAC.Command.add dest (TAC.Operand.var leftTemp) (TAC.Operand.var rightTemp)]

/--
If the subexpression code computes the left and right values into the generated
temporaries, then the combined addition code computes the source addition into
the requested destination.
-/
theorem compileIntAddition_correct
    (store : Store) (dest : VarName) (counter : TempCounter)
    (left right : IntExpr) (leftCode rightCode : TAC.Program)
    (hright :
      TAC.Program.exec rightCode (TAC.Program.exec leftCode store)
          (intTempName (nextTemp counter)) =
        IntExpr.eval store right)
    (hleft_final :
      TAC.Program.exec rightCode (TAC.Program.exec leftCode store)
          (intTempName counter) =
        IntExpr.eval store left) :
    TAC.Program.exec
        (compileIntAddition dest counter leftCode rightCode) store dest =
      IntExpr.eval store (IntExpr.add left right) := by
  simp [compileIntAddition, hright, hleft_final]

end Flatten
end Curify
