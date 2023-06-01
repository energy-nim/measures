import
  std/[sugar, tables],
  ./unit


type
  TimeUnits* = enum
    Milliseconds,
    Seconds,
    Minutes,
    Hours,
    Days
  Time* = object of Unit[BiggestFloat, TimeUnits]


proc mls*(value: float): Time =
  result = Time(value: value, unit: Milliseconds)

proc secs*(value: float): Time =
  result = Time(value: value, unit: Seconds)

proc mins*(value: float): Time =
  result = Time(value: value, unit: Minutes)

proc hours*(value: float): Time =
  result = Time(value: value, unit: Hours)

proc days*(value: float): Time =
  result = Time(value: value, unit: Days)


const equalityTable = {
  (Milliseconds, Milliseconds): (m: float) => m,
  (Milliseconds, Seconds): (m: float) => m / 1000,
  (Milliseconds, Minutes): (m: float) => (m / 1000) / 60,
  (Milliseconds, Hours): (m: float) => ((m / 1000) / 60) / 60,
  (Milliseconds, Days): (m: float) => (((m / 1000) / 60) / 60) / 24,
  (Seconds, Milliseconds): (s: float) => s * 1000,
  (Seconds, Seconds): (s: float) => s,
  (Seconds, Minutes): (s: float) => s / 60,
  (Seconds, Hours): (s: float) => (s / 60) / 60,
  (Seconds, Days): (s: float) => ((s / 60) / 60) / 24,
  (Minutes, Milliseconds): (m: float) => m * 60 * 1000,
  (Minutes, Seconds): (m: float) => m * 60,
  (Minutes, Minutes): (m: float) => m,
  (Minutes, Hours): (m: float) => m / 60,
  (Minutes, Days): (m: float) => (m / 60) / 60,
  (Hours, Milliseconds): (h: float) => h * 60 * 60 * 1000,
  (Hours, Seconds): (h: float) => h * 60 * 60,
  (Hours, Minutes): (h: float) => h * 60,
  (Hours, Hours): (h: float) => h,
  (Hours, Days): (h: float) => h / 24,
  (Days, Milliseconds): (d: float) => d * 24 * 60 * 60 * 1000,
  (Days, Seconds): (d: float) => d * 24 * 60 * 60,
  (Days, Minutes): (d: float) => d * 24 * 60,
  (Days, Hours): (d: float) => d * 24,
  (Days, Days): (d: float) => d,
}.toTable


proc equalities*(self: typedesc[Time]): auto = equalityTable
