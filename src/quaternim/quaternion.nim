
type
  Quaternion* = ref object
    r*,ci*,cj*,ck*: float

type QDivByZeroDefect* = object of ArithmeticDefect