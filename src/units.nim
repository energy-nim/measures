import ./units/temperature
import ./units/angle

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
