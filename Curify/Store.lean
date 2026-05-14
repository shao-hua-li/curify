import Curify.Core

namespace Curify

/-!
A store is the first model of program state in Curify. It maps every variable
name to the integer value currently associated with that name.
-/

/-- Integer program state, modeled as a total map from names to values. -/
abbrev Store := VarName -> IntValue

namespace Store

/-- Return a store like `store`, except `name` now maps to `value`. -/
def update (store : Store) (name : VarName) (value : IntValue) : Store :=
  fun query => if query = name then value else store query

/-- Updating a name changes the value read back at that same name. -/
@[simp]
theorem update_same (store : Store) (name : VarName) (value : IntValue) :
    update store name value name = value := by
  simp [update]

/-- Updating one name leaves a different name unchanged. -/
theorem update_other {store : Store} {updated query : VarName} {value : IntValue}
    (h : query ≠ updated) :
    update store updated value query = store query := by
  simp [update, h]

end Store
end Curify
