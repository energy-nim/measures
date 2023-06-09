import
  std/[math, tables],
  ./angle,
  ./information,
  ./temperature


type
  OperableUnit = Angle | Information | Temperature
  ComparableUnit = concept x
    x.value is float | float64 | BiggestFloat
    x.unit


proc isOf*[T, U](self: T, unit: U): bool {.inline.} = self.unit == unit

proc getValueAs*[T, U](self: T, unit: U): auto =
  result = T.equalities[(self.unit, unit)](self.value)

proc to*[T, U](self: var T, unit: U) =
  if self.unit == unit:
    return

  self.value = self.getValueAs(unit)
  self.unit = unit


proc `==`*(self, other: ComparableUnit): bool =
  if self.unit == other.unit:
    result = self.value == other.value
  else:
    result = self.value == other.getValueAs(self.unit)

proc `!=`*(self, other: ComparableUnit): bool =
  if self.unit == other.unit:
    result = self.value != other.value
  else:
    result = self.value != other.getValueAs(self.unit)

proc `~=`*[T: OperableUnit](self, other: T): bool =
  if self.unit == other.unit:
    result = almostEqual(self.value, other.value)
  else:
    result = almostEqual(self.value, other.getValueAs(self.unit))


proc `+`*[T: OperableUnit](self, other: T): T =
  if self.unit == other.unit:
    result = T(value: self.value + other.value, unit: self.unit)
  else:
    result = T(value: self.value + other.getValueAs(self.unit), unit: self.unit)

proc `-`*[T: OperableUnit](self, other: T): T =
  if self.unit == other.unit:
    result = T(value: self.value - other.value, unit: self.unit)
  else:
    result = T(value: self.value - other.getValueAs(self.unit), unit: self.unit)

proc `*`*[T: OperableUnit](self: T, value: float): T =
  result = T(value: self.value * value, unit: self.unit)

proc `/`*[T: OperableUnit](self: T, value: float): T =
  result = T(value: self.value / value, unit: self.unit)


export tables
