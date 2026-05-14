namespace Curify

/-!
Curify starts with integer variables. We represent variable names as strings and
integer values as Lean's mathematical integers, keeping the first core objects
small before adding stores, syntax, and semantics.
-/

/-- A source or compiler-generated variable name. -/
abbrev VarName := String

/-- The first value domain Curify can compute with. -/
abbrev IntValue := Int

end Curify
