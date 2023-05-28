import unittest

import units/temperature


test "celsius tests":
  let testingTemp = 25.°C
  check testingTemp.isOf(Celsius)
  check testingTemp.getAs(Farenheit) == 77.0
  check testingTemp.getAs(Kelvin) == 298.15
  
  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getAs(Celsius) == 25.0

  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getAs(Celsius) == 25.0

test "farenheit tests":
  let testingTemp = 77.°F
  check testingTemp.isOf(Farenheit)
  check testingTemp.getAs(Celsius) == 25.0
  check testingTemp.getAs(Kelvin) == 298.15

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getAs(Farenheit) == 77.0
  
  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getAs(Farenheit) == 77.0

test "kelvin tests":
  let testingTemp = 298.15.°K
  check testingTemp.isOf(Kelvin)
  check testingTemp.getAs(Celsius) == 25.0
  check testingTemp.getAs(Farenheit) == 77.0

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getAs(Kelvin) == 298.15

  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getAs(Kelvin) == 298.15