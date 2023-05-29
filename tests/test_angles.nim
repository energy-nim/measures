import unittest

import units/[core, angle]
import std/math

test "degrees tests":
  let myDeg = 180.°
  check myDeg.isOf(Degrees)
  check myDeg.getValueAs(Radians) == 3.141592653589793
  
  myDeg.to(Radians)
  check myDeg.isOf(Radians)
  check myDeg.getValueAs(Degrees) == 180.0

  # `~=` is the operator for almost equality (due to the formula's nature, there might be imprecissions)  
  check 80.° ~= 1.396263401595464.rad