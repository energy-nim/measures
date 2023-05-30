import std/tables
import ./base

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
  (Celsius, Celsius): proc(c: float): float = c,
  (Celsius, Farenheit): proc(c: float): float = (c * 1.8) + 32,
  (Celsius, Kelvin): proc(c: float): float = c + 273.15,
  (Farenheit, Farenheit): proc(f: float): float = f,
  (Farenheit, Celsius): proc(f: float): float = (f - 32) / 1.8,
  (Farenheit, Kelvin): proc(f: float): float = ((f - 32) / 1.8) + 273.15,
  (Kelvin, Kelvin): proc(k: float): float = k,
  (Kelvin, Celsius): proc(k: float): float = k - 273.15,
  (Kelvin, Farenheit): proc(k: float): float = ((k - 273.15) * 1.8) + 32
}.toTable


proc equalities*(self: Temperature): auto = equalityTable
