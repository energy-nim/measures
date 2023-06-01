import
  std/[sugar, tables],
  ./unit


type
  ConversionMode* = enum
    Standard,
    Binary
  InformationUnit* = enum
    Byte,
    Kilobyte,
    Megabyte,
    Gigabyte,
    Terabyte
  Information* = object of Unit[BiggestFloat, InformationUnit]


var conversionRate = Standard

proc setConversionMode*(_: typedesc[Information],
    mode: ConversionMode = Standard) =
  conversionRate = mode


proc b*(value: BiggestFloat): Information =
  result = Information(value: value, unit: Byte)

proc kb*(value: BiggestFloat): Information =
  result = Information(value: value, unit: Kilobyte)

proc mb*(value: BiggestFloat): Information =
  result = Information(value: value, unit: Megabyte)

proc gb*(value: BiggestFloat): Information =
  result = Information(value: value, unit: Gigabyte)

proc tb*(value: BiggestFloat): Information =
  result = Information(value: value, unit: Terabyte)


const equalityTable = {
  Standard: {
    (Byte, Byte): (b: BiggestFloat) => b,
    (Byte, Kilobyte): (b: BiggestFloat) => b / 1000,
    (Byte, Megabyte): (b: BiggestFloat) => b / 1000 / 1000,
    (Byte, Gigabyte): (b: BiggestFloat) => b / 1000 / 1000 / 1000,
    (Byte, Terabyte): (b: BiggestFloat) => b / 1000 / 1000 / 1000 / 1000
  }.toTable,
  Binary: {
    (Byte, Byte): (b: BiggestFloat) => b,
    (Byte, Kilobyte): (b: BiggestFloat) => b / 1024,
    (Byte, Megabyte): (b: BiggestFloat) => b / 1024 / 1024,
    (Byte, Gigabyte): (b: BiggestFloat) => b / 1024 / 1024 / 1024,
    (Byte, Terabyte): (b: BiggestFloat) => b / 1024 / 1024 / 1024 / 1024
  }.toTable,
}.toTable


proc equalities*(self: typedesc[Information]): auto = equalityTable[conversionRate]
