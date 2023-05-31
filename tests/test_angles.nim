import
  std/[math, unittest],
  measures/[core, angle]


test "degrees tests":
  let myDeg = 180.°
  check myDeg.isOf(Degrees)
  check myDeg.getValueAs(Radians) == PI
  
  myDeg.to(Radians)
  check myDeg.isOf(Radians)
  check myDeg.getValueAs(Degrees) == 180.0

  # `~=` is the operator for almost equality (due to the formula's nature, there might be imprecissions)  
  check 80.° ~= 1.396263401595464.rad

  check 180.° === 180.°
  check 180.° === PI.rad
  check 180.° != 0.°
  check 180.° != 0.rad

test "radians test":
  let myRad = PI.rad
  check myRad.isOf(Radians)
  check myRad.getValueAs(Degrees) == 180.0

  myRad.to(Degrees)
  check myRad.isOf(Degrees)
  check myRad.getValueAs(Radians) == PI

  check PI.rad === 180.°
  check PI.rad === PI.rad
  check PI.rad != 0.°
  check PI.rad != 0.rad
