import std/tables


type
  TemperatureUnit* = enum
    Celsius,
    Kelvin,
    Farenheit
  Temperature* = ref object
    val: float
    unit: TemperatureUnit


proc `°C`*(val: float): Temperature =
  result = Temperature(val: val, unit: Celsius)

proc `°F`*(val: float): Temperature =
  result = Temperature(val: val, unit: Farenheit)

proc `°K`*(val: float): Temperature =
  result = Temperature(val: val, unit: Kelvin)


const equalityTable = {
  (Celsius, Celsius): proc(c: float): float = c * 1,
  (Celsius, Farenheit): proc(c: float): float = (c * 1.8) + 32,
  (Celsius, Kelvin): proc(c: float): float = c + 273.15,
  (Farenheit, Farenheit): proc(f: float): float = f * 1,
  (Farenheit, Celsius): proc(f: float): float = (f - 32) / 1.8,
  (Farenheit, Kelvin): proc(f: float): float = ((f - 32) / 1.8) + 273.15,
  (Kelvin, Kelvin): proc(k: float): float = k * 1,
  (Kelvin, Celsius): proc(k: float): float = k - 273.15,
  (Kelvin, Farenheit): proc(k: float): float = ((k - 273.15) * 1.8) + 32
}.toTable


proc isOf*(self: Temperature, unit: TemperatureUnit): bool {.inline.} = self.unit == unit

proc getValue*(self: Temperature): float {.inline.} = self.val

proc getUnit*(self: Temperature): TemperatureUnit {.inline.} = self.unit

proc getValueAs*(self: Temperature, unit: TemperatureUnit): float =
  result = equalityTable[(self.unit, unit)](self.val)

proc to*(self: Temperature, unit: TemperatureUnit) =
  if self.unit == unit:
    return

  self.val = self.getValueAs(unit)
  self.unit = unit

proc `==`*(self, other: Temperature): bool =
  if self.unit == other.unit:
    result = self.val == other.val
  else:
    result = self.val == other.getValueAs(self.unit)
