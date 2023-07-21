import unittest

import quaternim
test "creation":
  let q1 = initQuaternion(1.0,2.0,3.0,4.0) 
  let q2 = initQuaternion(1.0,-2.0,3.0,-4.0)
  assert $q1 == "1.0 + (2.0)i + (3.0)j + (4.0)k"
  assert $q2 == "1.0 + (-2.0)i + (3.0)j + (-4.0)k"


test "product":
  let q1 = initQuaternion(1.0,2.0,3.0,4.0) 
  let q2 = initQuaternion(6.0,7.0,8.0,9.0) 
  let qr = initQuaternion(-68.0,14.0,36.0,28.0) 
  assert $(q1*q2) == $qr

test "subtraction":
  let q1 = initQuaternion(1.0,2.0,3.0,4.0) 
  let q2 = initQuaternion(6.0,7.0,8.0,9.0) 
  let qr = initQuaternion(-5.0,-5.0,-5.0,-5.0) 
  assert $(q1-q2) == $qr

test "addition":
  let q1 = initQuaternion(1.0,2.0,3.0,4.0) 
  let q2 = initQuaternion(6.0,7.0,8.0,9.0) 
  let qr = initQuaternion(7.0,9.0,11.0,13.0) 
  assert $(q1+q2) == $qr

test "scalar multiplication and scalar division":
  let q = initQuaternion(1.0,2.0,3.0,4.0) 
  let qr = initQuaternion(2.0,4.0,6.0,8.0) 
  assert $qr == $(q*2) and $qr == $(2*q) and $(2*q/2) == $q

test "conjugate":
  let q = initQuaternion(1.0,2.0,3.0,4.0) 
  let qr = initQuaternion(1.0,-2.0,-3.0,-4.0) 
  assert $qr == $(conj(q))

test "norm":
  let q1 = initQuaternion(5.0,5.0,5.0,5.0) 
  let q2 = initQuaternion(2.0,0.0,0.0,0.0) 
  assert norm(q1) == 10 and norm(q1*q2) == 20

test "inverse":
  let q = initQuaternion(5.0,5.0,5.0,5.0) 
  let qr = initQuaternion(0.05,-0.05,-0.05,-0.05) 
  assert $(inverse(q)) == $qr and is_identity(inverse(q)*q)

test "unit quaternion":
  let q = initQuaternion(5.0,5.0,5.0,5.0) 
  let qr = initQuaternion(0.5,0.5,0.5,0.5) 
  assert $(normalize(q)) == $qr and is_unit(normalize(q)) and is_unit(qr)

test "Zero Quaternion has no Inverse Exception":
  let q = initQuaternion(0.0,0.0,0.0,0.0) 
  try:
    discard inverse(q)
    assert false
  except QDivByZeroDefect:
    assert true 
  
test "Attempted to divide the quaternion by 0 Exception":
  let q = initQuaternion(1.0,2.0,3.0,4.0) 

  try:
    discard q/0.0
    assert false
  except QDivByZeroDefect:
    assert true 

test "Attempted to make transform the zero Quaternion into a unit Quaternion Exception":
  let q = initQuaternion(0.0,0.0,0.0,0.0) 
  try:
    discard normalize(q)
    assert false
  except QDivByZeroDefect:
    assert true 