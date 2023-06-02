import
  std/[math, sugar, tables],
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
    (Byte, Megabyte): (b: BiggestFloat) => b / 1000.pow(2.0),
    (Byte, Gigabyte): (b: BiggestFloat) => b / 1000.pow(3.0),
    (Byte, Terabyte): (b: BiggestFloat) => b / 1000.pow(4.0),
    (Kilobyte, Byte): (k: BiggestFloat) => k * 1000,
    (Kilobyte, Kilobyte): (k: BiggestFloat) => k,
    (Kilobyte, Megabyte): (k: BiggestFloat) => k / 1000,
    (Kilobyte, Gigabyte): (k: BiggestFloat) => k / 1000.pow(2.0),
    (Kilobyte, Terabyte): (k: BiggestFloat) => k / 1000.pow(3.0),
    (Megabyte, Byte): (m: BiggestFloat) => m * 1000.pow(2.0),
    (Megabyte, Kilobyte): (m: BiggestFloat) => m * 1000,
    (Megabyte, Megabyte): (m: BiggestFloat) => m,
    (Megabyte, Gigabyte): (m: BiggestFloat) => m / 1000,
    (Megabyte, Terabyte): (m: BiggestFloat) => m / 1000.pow(2.0),
    (Gigabyte, Byte): (g: BiggestFloat) => g * 1000.pow(3.0),
    (Gigabyte, Kilobyte): (g: BiggestFloat) => g * 1000.pow(2.0),
    (Gigabyte, Megabyte): (g: BiggestFloat) => g * 1000,
    (Gigabyte, Gigabyte): (g: BiggestFloat) => g,
    (Gigabyte, Terabyte): (g: BiggestFloat) => g / 1000,
    (Terabyte, Byte): (t: BiggestFloat) => t * 1000.pow(4.0),
    (Terabyte, Kilobyte): (t: BiggestFloat) => t * 1000.pow(3.0),
    (Terabyte, Megabyte): (t: BiggestFloat) => t * 1000.pow(2.0),
    (Terabyte, Gigabyte): (t: BiggestFloat) => t * 1000,
    (Terabyte, Terabyte): (t: BiggestFloat) => t
  }.toTable,
  Binary: {
    (Byte, Byte): (b: BiggestFloat) => b,
    (Byte, Kilobyte): (b: BiggestFloat) => b / 1024,
    (Byte, Megabyte): (b: BiggestFloat) => b / 1024.pow(2.0),
    (Byte, Gigabyte): (b: BiggestFloat) => b / 1024.pow(3.0),
    (Byte, Terabyte): (b: BiggestFloat) => b / 1024.pow(4.0),
    (Kilobyte, Byte): (k: BiggestFloat) => k * 1024,
    (Kilobyte, Kilobyte): (k: BiggestFloat) => k,
    (Kilobyte, Megabyte): (k: BiggestFloat) => k / 1024,
    (Kilobyte, Gigabyte): (k: BiggestFloat) => k / 1024.pow(2.0),
    (Kilobyte, Terabyte): (k: BiggestFloat) => k / 1024.pow(3.0),
    (Megabyte, Byte): (m: BiggestFloat) => m * 1024.pow(2.0),
    (Megabyte, Kilobyte): (m: BiggestFloat) => m * 1024,
    (Megabyte, Megabyte): (m: BiggestFloat) => m,
    (Megabyte, Gigabyte): (m: BiggestFloat) => m / 1024,
    (Megabyte, Terabyte): (m: BiggestFloat) => m / 1024.pow(2.0),
    (Gigabyte, Byte): (g: BiggestFloat) => g * 1024.pow(3.0),
    (Gigabyte, Kilobyte): (g: BiggestFloat) => g * 1024.pow(2.0),
    (Gigabyte, Megabyte): (g: BiggestFloat) => g * 1024,
    (Gigabyte, Gigabyte): (g: BiggestFloat) => g,
    (Gigabyte, Terabyte): (g: BiggestFloat) => g / 1024,
    (Terabyte, Byte): (t: BiggestFloat) => t * 1024.pow(4.0),
    (Terabyte, Kilobyte): (t: BiggestFloat) => t * 1024.pow(3.0),
    (Terabyte, Megabyte): (t: BiggestFloat) => t * 1024.pow(2.0),
    (Terabyte, Gigabyte): (t: BiggestFloat) => t * 1024,
    (Terabyte, Terabyte): (t: BiggestFloat) => t
  }.toTable,
}.toTable


proc equalities*(self: typedesc[Information]): auto = equalityTable[conversionRate]
