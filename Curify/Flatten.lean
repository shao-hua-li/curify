import Curify.Core

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

end Flatten
end Curify
