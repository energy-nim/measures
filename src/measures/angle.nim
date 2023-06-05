import
  std/[math, sugar, tables],
  ./unit


type
  AngleUnit* = enum
    Degrees,
    Radians
  Angle* = object of Unit[float, AngleUnit]


proc `°`*(value: float): Angle =
  result = Angle(value: value, unit: Degrees)

proc rad*(value: float): Angle =
  result = Angle(value: value, unit: Radians)


const equalityTable = {
  (Degrees, Degrees): (d: float) => d,
  (Degrees, Radians): (d: float) => d * (PI / 180),
  (Radians, Radians): (r: float) => r,
  (Radians, Degrees): (r: float) => r * (180 / PI)
}.toTable


proc equalities*(self: typedesc[Angle]): auto = equalityTable


proc truncate*(self: var Angle) =
  if self.unit == Degrees:
    self.value = self.value mod 360
  elif self.unit == Radians:
    self.value = self.value mod (2 * PI)

proc normalize*(self: var Angle) =
  self.truncate()

  if self.value < 0:
    if self.unit == Degrees:
      self.value = 360 + self.value
    elif self.unit == Radians:
      self.value = (2 * PI) + self.value

proc invert*(self: var Angle) =
  if self.value < 0:
    self.normalize()

  if self.unit == Degrees and self.value > 360:
    self.truncate()
  elif self.unit == Radians and self.value > (2 * PI):
    self.truncate()

  if self.unit == Degrees:
    self.value = 360 - self.value
  elif self.unit == Radians:
    self.value = (2 * PI) - self.value

