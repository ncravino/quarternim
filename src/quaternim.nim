import quaternim/quaternion

import std/strformat
import std/math 

proc initQuaternion*(r: float, ci: float, cj: float, ck: float): Quaternion =
  ## Initializes quaternion r + ci\*j + cj\*j + ck\*k
  return Quaternion(r: r, ci: ci, cj: cj, ck: ck)

proc scalarToQuaternion*(s:float) : Quaternion = 
  ## Creates a scalar quaternion from s
  return Quaternion(r:s , ci:0.0, cj: 0.0, ck:0.0)

proc real*(q : Quaternion) : float = 
  ## Gets the real part of the quaternion
  return q.r

proc vector*(q: Quaternion) : (float,float,float) = 
  ## Gets the vector part of the quaternion
  return (q.ci, q.cj, q.ck)

proc is_zero* (q : Quaternion) : bool = 
  ## True if q is the zero quaternion
  return q.r == 0 and q.ci == 0 and q.cj == 0 and q.ck == 0 

proc is_identity* (q : Quaternion) : bool = 
  ## True if q is the multiplicative identity quaternion
  return q.r == 1.0 and q.ci == 0 and q.cj == 0 and q.ck == 0 

proc is_vector* (q : Quaternion) : bool = 
  ## True if q is a vector quaternion
  return q.r == 0 and (q.ci != 0 or q.cj != 0 or q.ck != 0)

proc is_scalar* (q : Quaternion) : bool = 
  ## True if q is a scalar quaternion
  return q.r != 0 and q.ci == 0 and q.cj == 0 and q.ck == 0

proc `==`* (q1: Quaternion, q2: Quaternion) : bool =
  ## True if q1 and q2 are the same quaternion
  return q1.r == q2.r and q1.ci == q2.ci and q1.cj == q2.cj and q1.ck == q2.ck

proc `$`*(q: Quaternion): string =
  ## Algebraic representation in the form of r + (ci)i + (cj)j + (ck)k
  return &"{q.r} + ({q.ci})i + ({q.cj})j + ({q.ck})k"
  

proc `+`*(q1: Quaternion, q2: Quaternion): Quaternion =
  ## Addition of two quaternions
  return Quaternion(r: q1.r+q2.r, ci: q1.ci+q2.ci, cj: q1.cj+q2.cj,
      ck: q1.ck+q2.ck)

proc `-`*(q1: Quaternion, q2: Quaternion): Quaternion =
  ## Subtraction of a quaternion form another
  return Quaternion(r: q1.r-q2.r, ci: q1.ci-q2.ci, cj: q1.cj-q2.cj,
      ck: q1.ck-q2.ck)

proc `*`* (s : float, q : Quaternion) : Quaternion = 
  ## Left scalar multiplication of s by  q
  return Quaternion(r: s*q.r, ci: s*q.ci, cj: s*q.cj, ck: s*q.ck)

proc `*`* (q : Quaternion, s : float) : Quaternion = 
  ## Right scalar multiplication of q by s
  return Quaternion(r: s*q.r, ci: s*q.ci, cj: s*q.cj, ck: s*q.ck)

proc `/`* (q : Quaternion, s : float) : Quaternion {.raises: [QDivByZeroDefect].} = 
  ## Right scalar division of q by non-zero s
  if s == 0:
     raise newException(QDivByZeroDefect, "Attempted to divide the quaternion by 0") 
  return Quaternion(r: q.r/s, ci: q.ci/s, cj: q.cj/s, ck: q.ck/s)

proc `*`*(q1: Quaternion, q2: Quaternion): Quaternion =
  ## Hamilton Product of q1 and q2
  let r = q1.r*q2.r - q1.ci*q2.ci - q1.cj*q2.cj - q1.ck*q2.ck
  let ci = q1.r*q2.ci + q1.ci*q2.r + q1.cj*q2.ck - q1.ck*q2.cj
  let cj = q1.r*q2.cj - q1.ci*q2.ck + q1.cj*q2.r + q1.ck*q2.ci
  let ck = q1.r*q2.ck + q1.ci*q2.cj - q1.cj*q2.ci + q1.ck*q2.r
  return Quaternion(r: r, ci: ci, cj: cj, ck: ck)

proc conj*(q: Quaternion): Quaternion =
  ## Complex Conjugate of q
  return Quaternion(r: q.r, ci: -q.ci, cj: -q.cj, ck: -q.ck)

proc norm*(q : Quaternion) : float = 
  ## Norm of q
  return sqrt(q.r^2 + q.ci^2 + q.cj^2 + q.ck^2)

proc inverse*(q : Quaternion) : Quaternion  {.raises: [QDivByZeroDefect].} = 
  ## Inverse of q
  if is_zero (q):
    raise newException(QDivByZeroDefect, "Zero Quaternion has no Inverse")
  conj(q)*(1.0/(q.r^2 + q.ci^2 + q.cj^2 + q.ck^2))

proc unit*(q : Quaternion) : Quaternion {.raises: [QDivByZeroDefect].} = 
  ## Get Versor / Unit Quaternion from q
  if is_zero(q):      
     raise newException(QDivByZeroDefect, "Attempted to make transform the zero Quaternion into a unit Quaternion") 
  let q_norm = norm(q)
  return q / q_norm

proc is_unit* (q : Quaternion) : bool = 
  ## True if q has norm 1, i.e. is the unit quaternion
  norm(q) == 1
