import ./units/temperature

proc `==`*[T: Temperature](self, other: T): bool =
  echo self.val
  echo self.unit
  if self.unit == other.unit:
    result = self.val == other.val
  else:
    result = self.val == other.getValueAs(self.unit)
