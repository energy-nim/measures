import std/[tables, math]
import ./base

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
  (Degrees, Degrees): proc(d: float): float = d,
  (Degrees, Radians): proc(d: float): float = d * (PI / 180),
  (Radians, Radians): proc(r: float): float = r,
  (Radians, Degrees): proc(r: float): float = r * (180 / PI)
}.toTable


proc equalities*(self: Angle): auto = equalityTable
