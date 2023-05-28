import unittest

import units
import units/[angle, temperature]


test "celsius tests":
  let testingTemp = 25.°C
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Farenheit) == 77.0
  check testingTemp.getValueAs(Kelvin) == 298.15
  
  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Celsius) == 25.0

  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Celsius) == 25.0

  check 25.°C === 25.°C
  check 25.°C === 77.°F
  check 25.°C === 298.15.°K
  check 25.°C != 25.1.°C
  check 25.°C != 0.°F
  check 25.°C != 0.°K

test "farenheit tests":
  let testingTemp = 77.°F
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Celsius) == 25.0
  check testingTemp.getValueAs(Kelvin) == 298.15

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Farenheit) == 77.0
  
  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Farenheit) == 77.0

test "kelvin tests":
  let testingTemp = 298.15.°K
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Celsius) == 25.0
  check testingTemp.getValueAs(Farenheit) == 77.0

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Kelvin) == 298.15

  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Kelvin) == 298.15
