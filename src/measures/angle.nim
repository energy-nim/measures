import 
  std/[math, sugar, tables],
  ./unit


type
  AngleUnit* = enum
    Degrees,
    Radians
  Angle* = ref object of Unit[float, AngleUnit]


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
