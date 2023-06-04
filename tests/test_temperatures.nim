import
  std/unittest,
  measures/[core, temperature]


test "celsius tests":
  var testingTemp = 25.°C
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Farenheit) == 77.0
  check testingTemp.getValueAs(Kelvin) == 298.15

  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Celsius) == 25.0

  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Celsius) == 25.0

  check 25.°C == 25.°C
  check 25.°C == 77.°F
  check 25.°C == 298.15.°K
  check 25.°C != 25.1.°C
  check 25.°C != 0.°F
  check 25.°C != 0.°K

test "farenheit tests":
  var testingTemp = 77.°F
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Celsius) == 25.0
  check testingTemp.getValueAs(Kelvin) == 298.15

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Farenheit) == 77.0

  testingTemp.to(Kelvin)
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Farenheit) == 77.0

  check 77.°F == 77.°F
  check 77.°F == 25.°C
  check 77.°F == 298.15.°K
  check 77.°F != 77.1.°F
  check 77.°F != 0.°C
  check 77.°F != 0.°K

test "kelvin tests":
  var testingTemp = 298.15.°K
  check testingTemp.isOf(Kelvin)
  check testingTemp.getValueAs(Celsius) == 25.0
  check testingTemp.getValueAs(Farenheit) == 77.0

  testingTemp.to(Celsius)
  check testingTemp.isOf(Celsius)
  check testingTemp.getValueAs(Kelvin) == 298.15

  testingTemp.to(Farenheit)
  check testingTemp.isOf(Farenheit)
  check testingTemp.getValueAs(Kelvin) == 298.15

  check 298.15.°K == 298.15.°K
  check 298.15.°K == 25.°C
  check 298.15.°K == 77.°F
  check 298.15.°K != 298.16.°K
  check 298.15.°K != 0.°C
  check 298.15.°K != 0.°F

test "temperature arithmetics":
  check (20.°C + 5.°C) == 25.°C
  check (20.°C + 5.°C) == 77.°F
  check (20.°C + 5.°C) == 298.15.°K
  check (20.°C + 41.°F) == 25.°C
  check (20.°C + 41.°F) == 77.°F
  check (20.°C + 41.°F) == 298.15.°K
  check (20.°C + 278.15.°K) == 25.°C
  check (20.°C + 278.15.°K) == 77.°F
  check (20.°C + 278.15.°K) == 298.15.°K

  check (30.°C - 5.°C) == 25.°C
  check (30.°C - 5.°C) == 77.°F
  check (30.°C - 5.°C) == 298.15.°K
  check (30.°C - 41.°F) == 25.°C
  check (30.°C - 41.°F) == 77.°F
  check (30.°C - 41.°F) == 298.15.°K
  check (30.°C - 278.15.°K) == 25.°C
  check (30.°C - 278.15.°K) == 77.°F
  check (30.°C - 278.15.°K) == 298.15.°K

  check (20.°C + 50.°F - 278.15.°K) == 25.°C
  check (20.°C + 50.°F - 278.15.°K) == 77.°F
  check (20.°C + 50.°F - 278.15.°K) == 298.15.°K

  check (12.5.°C * 2) == 25.°C
  check (12.5.°C * 2) == 77.°F
  check (12.5.°C * 2) == 298.15.°K
  check (50.°C / 2) == 25.°C
  check (50.°C / 2) == 77.°F
  check (50.°C / 2) == 298.15.°K
