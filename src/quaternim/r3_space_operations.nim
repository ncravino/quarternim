import quaternion 
import base_operations as base 
import std/math

type RotationQuaternion* = 
    # subtype of Unit Quaternion to explicitly represent Rotations
    ref object of UnitQuaternion

type vector3d* = tuple[x:float, y:float, z:float]

proc is_rotation*(q : RotationQuaternion) : bool = true 

proc `*`(q1:RotationQuaternion, q2:RotationQuaternion) : RotationQuaternion = 
    return cast[RotationQuaternion](base.`*`(q1,q2))

proc rotationQuaternion*(yaw: float, pitch: float,
    # Creates a rotationQuaterion from yaw, pitch, and roll
        roll: float): RotationQuaternion =
    let r_cos = cos(roll * 0.5)
    let r_sin = sin(roll * 0.5)
    let p_cos = cos(pitch * 0.5)
    let p_sin = sin(pitch * 0.5)
    let y_cos = cos(yaw * 0.5)
    let y_sin = sin(yaw * 0.5)

    let roll_q = RotationQuaternion(r:r_cos, ci:r_sin, cj:0.0, ck: 0.0)
    let pitch_q = RotationQuaternion(r:p_cos, ci:0.0, cj:p_sin, ck: 0.0)
    let yaw_q = RotationQuaternion(r:y_cos, ci:0.0, cj:0.0, ck: y_sin)

    return yaw_q * pitch_q * roll_q 


proc approximate_equal*(t1 :  vector3d, t2:  vector3d, places : int) : bool =
    round(t1.x-t2.x, places) == 0 and 
        round(t1.y-t2.y, places) == 0 and 
        round(t1.z-t2.z, places) == 0

proc rotateVector*(rq: RotationQuaternion, v : vector3d): vector3d  =
    # Rotate a 3d vector given the rotation represented by the quaternion
    let vectorQuaternion = Quaternion(r: 0, ci: v.x, cj: v.y, ck: v.z)
    let rotatedVector = rq * vectorQuaternion * conj(rq)
    return (x: rotatedVector.ci, y: rotatedVector.cj, z: rotatedVector.ck)
