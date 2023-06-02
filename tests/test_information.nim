import
  std/unittest,
  measures/[core, information]


test "bytes tests (standard)":
  check 1.b === 1.b
  check 1.b === 0.001.kb
  check 1.b === 0.000001.mb
  check 1.b === 0.000000001.gb
  check 1.b === 0.000000000001.tb

test "kilobytes test (standard)":
  check 1.kb === 1000.b
  check 1.kb === 1.kb
  check 1.kb === 0.001.mb
  check 1.kb === 0.000001.gb
  check 1.kb === 0.000000001.tb

test "megabytes test (standard)":
  check 1.mb === 1000000.b
  check 1.mb === 1000.kb
  check 1.mb === 1.mb
  check 1.mb === 0.001.gb
  check 1.mb === 0.000001.tb

test "gigabytes test (standard)":
  check 1.gb === 1000000000.b
  check 1.gb === 1000000.kb
  check 1.gb === 1000.mb
  check 1.gb === 1.gb
  check 1.gb === 0.001.tb

test "terabytes test (standard)":
  check 1.tb === 1000000000000.0.b # Note that omitting the floating point causes the compiler considering it an int64
  check 1.tb === 1000000000.kb
  check 1.tb === 1000000.mb
  check 1.tb === 1000.gb
  check 1.tb === 1.tb


Information.setConversionMode(Binary)


test "bytes test (binary)":
  check 1.b === 1.b
  check 1.b === 0.0009765625.kb
  check 1.b === 0.00000095367431640625.mb
  check 1.b === 0.0000000009313225746154785.gb     # Observe how imprecise it becomes when the 
  check 1.b === 0.0000000000009094947017729282.tb  # conversion gap becomes bigger

test "kilobytes test (binary)":
  check 1.kb === 1024.b
  check 1.kb === 1.kb
  check 1.kb === 0.0009765625.mb
  check 1.kb === 0.00000095367431640625.gb
  check 1.kb === 0.0000000009313225746154785.tb

test "megabytes test (binary)":
  check 1.mb === 1048576.b
  check 1.mb === 1024.kb
  check 1.mb === 1.mb
  check 1.mb === 0.0009765625.gb
  check 1.mb === 0.00000095367431640625.tb

test "gigabytes test (binary)":
  check 1.gb === 1073741824.b
  check 1.gb === 1048576.kb
  check 1.gb === 1024.mb
  check 1.gb === 1.gb
  check 1.gb === 0.0009765625.tb

test "terabytes test (binary)":
  check 1.tb === 1099511627776.0.b
  check 1.tb === 1073741824.kb
  check 1.tb === 1048576.mb
  check 1.tb === 1024.gb
  check 1.tb === 1.tb
