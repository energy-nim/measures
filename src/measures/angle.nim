import std/[math, sugar, tables]
import ./unit


type
  AngleUnit* = enum
    Degrees,
    Radians
  Angle* = ref object of Unit[AngleUnit]


proc `°`*(val: float): Angle =
  result = Angle(val: val, unit: Degrees)

proc rad*(val: float): Angle =
  result = Angle(val: val, unit: Radians)


const equalityTable = {
  (Degrees, Degrees): (d: float) => d,
  (Degrees, Radians): (d: float) => d * (PI / 180),
  (Radians, Radians): (r: float) => r,
  (Radians, Degrees): (r: float) => r * (180 / PI)
}.toTable


proc equalities*(self: typedesc[Angle]): auto = equalityTable
