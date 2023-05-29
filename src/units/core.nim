import std/[math, tables]
import ./temperature
import ./angle


proc isOf*[T, U](self: T, unit: U): bool {.inline.} = self.unit == unit

proc getValueAs*[T, U](self: T, unit: U): float =
  result = self.equalities[(self.unit, unit)](self.val)

proc to*[T, U](self: T, unit: U) =
  if self.unit == unit:
    return

  self.val = self.getValueAs(unit)
  self.unit = unit

#[
  Note: Using `==`the compiler gives priority to the language-default equality operator so this custom version is never applied.
  Further research is needed
]#
proc `===`*[T: Temperature | Angle](self, other: T): bool =
  echo self.val
  echo self.unit
  if self.unit == other.unit:
    result = self.val == other.val
  else:
    result = self.val == other.getValueAs(self.unit)

proc `!=`*[T: Temperature | Angle](self, other: T): bool =
  echo self.val
  echo self.unit
  if self.unit == other.unit:
    result = self.val != other.val
  else:
    result = self.val != other.getValueAs(self.unit)

proc `~=`*[T: Temperature | Angle](self, other: T): bool =
  echo self.val
  echo self.unit
  if self.unit == other.unit:
    result = almostEqual(self.val,other.val)
  else:
    result = almostEqual(self.val, other.getValueAs(self.unit))


export tables