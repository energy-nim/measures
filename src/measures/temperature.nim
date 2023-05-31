import 
  std/[sugar, tables],
  ./unit


type
  TemperatureUnit* = enum
    Celsius,
    Kelvin,
    Farenheit
  Temperature* = ref object of Unit[TemperatureUnit]


proc `°C`*(val: float): Temperature =
  result = Temperature(val: val, unit: Celsius)

proc `°F`*(val: float): Temperature =
  result = Temperature(val: val, unit: Farenheit)

proc `°K`*(val: float): Temperature =
  result = Temperature(val: val, unit: Kelvin)


const equalityTable = {
  (Celsius, Celsius): (c: float) => c,
  (Celsius, Farenheit): (c: float) => (c * 1.8) + 32,
  (Celsius, Kelvin): (c: float) => c + 273.15,
  (Farenheit, Farenheit): (f: float) => f,
  (Farenheit, Celsius): (f: float) => (f - 32) / 1.8,
  (Farenheit, Kelvin): (f: float) => ((f - 32) / 1.8) + 273.15,
  (Kelvin, Kelvin): (k: float) => k,
  (Kelvin, Celsius): (k: float) => k - 273.15,
  (Kelvin, Farenheit): (k: float) => ((k - 273.15) * 1.8) + 32
}.toTable


proc equalities*(self: typedesc[Temperature]): auto = equalityTable
