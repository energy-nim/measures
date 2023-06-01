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


proc mls*(value: BiggestFloat): Time =
  result = Time(value: value, unit: Milliseconds)

proc secs*(value: BiggestFloat): Time =
  result = Time(value: value, unit: Seconds)

proc mins*(value: BiggestFloat): Time =
  result = Time(value: value, unit: Minutes)

proc hours*(value: BiggestFloat): Time =
  result = Time(value: value, unit: Hours)

proc days*(value: BiggestFloat): Time =
  result = Time(value: value, unit: Days)


const equalityTable = {
  (Milliseconds, Milliseconds): (m: BiggestFloat) => m,
  (Milliseconds, Seconds): (m: BiggestFloat) => m / 1000,
  (Milliseconds, Minutes): (m: BiggestFloat) => (m / 1000) / 60,
  (Milliseconds, Hours): (m: BiggestFloat) => ((m / 1000) / 60) / 60,
  (Milliseconds, Days): (m: BiggestFloat) => (((m / 1000) / 60) / 60) / 24,
  (Seconds, Milliseconds): (s: BiggestFloat) => s * 1000,
  (Seconds, Seconds): (s: BiggestFloat) => s,
  (Seconds, Minutes): (s: BiggestFloat) => s / 60,
  (Seconds, Hours): (s: BiggestFloat) => (s / 60) / 60,
  (Seconds, Days): (s: BiggestFloat) => ((s / 60) / 60) / 24,
  (Minutes, Milliseconds): (m: BiggestFloat) => m * 60 * 1000,
  (Minutes, Seconds): (m: BiggestFloat) => m * 60,
  (Minutes, Minutes): (m: BiggestFloat) => m,
  (Minutes, Hours): (m: BiggestFloat) => m / 60,
  (Minutes, Days): (m: BiggestFloat) => (m / 60) / 60,
  (Hours, Milliseconds): (h: BiggestFloat) => h * 60 * 60 * 1000,
  (Hours, Seconds): (h: BiggestFloat) => h * 60 * 60,
  (Hours, Minutes): (h: BiggestFloat) => h * 60,
  (Hours, Hours): (h: BiggestFloat) => h,
  (Hours, Days): (h: BiggestFloat) => h / 24,
  (Days, Milliseconds): (d: BiggestFloat) => d * 24 * 60 * 60 * 1000,
  (Days, Seconds): (d: BiggestFloat) => d * 24 * 60 * 60,
  (Days, Minutes): (d: BiggestFloat) => d * 24 * 60,
  (Days, Hours): (d: BiggestFloat) => d * 24,
  (Days, Days): (d: BiggestFloat) => d,
}.toTable


proc equalities*(self: typedesc[Time]): auto = equalityTable
