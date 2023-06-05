import
  std/[math, unittest],
  measures/[core, angle]


test "degrees tests":
  var myDeg = 180.°
  check myDeg.isOf(Degrees)
  check myDeg.getValueAs(Radians) == PI

  myDeg.to(Radians)
  check myDeg.isOf(Radians)
  check myDeg.getValueAs(Degrees) == 180.0

  # `~=` is the operator for almost equality (due to the formula's nature, there might be imprecissions)
  check 80.° ~= 1.396263401595464.rad

  check 180.° == 180.°
  check 180.° == PI.rad
  check 180.° != 0.°
  check 180.° != 0.rad

test "radians test":
  var myRad = PI.rad
  check myRad.isOf(Radians)
  check myRad.getValueAs(Degrees) == 180.0

  myRad.to(Degrees)
  check myRad.isOf(Degrees)
  check myRad.getValueAs(Radians) == PI

  check PI.rad == 180.°
  check PI.rad == PI.rad
  check PI.rad != 0.°
  check PI.rad != 0.rad

test "angles arithmetics":
  check (100.° + 80.°) == 180.°
  check (1.rad + 2.rad) == 3.rad
  check (20.° + PI.rad) == 200.°

  check (200.° - 20.°) == 180.°
  check (2.rad - 1.rad) == 1.rad

  check (100.° + PI.rad - 30.°) == 250.°
  check (100.° + PI.rad + 80.°) == (2 * PI).rad

  check (90.° * 2) == 180.°
  check (PI.rad * 2) == (2 * PI).rad

  check (270.° / 3) == 90.°
  check (3.rad / 3) == 1.rad

test "angle-specific operations (degrees)":
  var myAngle = 720.°

  myAngle.truncate
  check myAngle.value == 0

  myAngle.value = 810
  myAngle.truncate
  check myAngle.value == 90

  myAngle.value = -810 # after truncating would be -90
  myAngle.normalize # -90 + 360
  check myAngle.value == 270

  myAngle.value = -810 # after normalizing would be 270
  myAngle.invert # 360 - 270
  check myAngle.value == 90

test "angle-specific operations (radians)":
  var myAngle = (3 * PI).rad

  myAngle.truncate
  check myAngle.value == PI

  myAngle.value = -3 * PI # after truncating would be -PI
  myAngle.normalize # -PI + 2PI
  check myAngle.value == PI

  myAngle.value = -5 * PI # after normalizing would be PI
  myAngle.invert # 2PI - PI
  check myAngle.value == PI