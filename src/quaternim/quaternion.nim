
type
  Quaternion* = ref object of RootObj
    r*, ci*, cj*, ck*: float

type UnitQuaternion* = ref object of Quaternion

