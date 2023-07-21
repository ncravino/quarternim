import unittest
import quaternim
import std/math 

let PITHIRD = PI/3

test "create rotation quaternion":
    let rq1 = rotationQuaternion(0.0,PITHIRD,0.0)
    let rq2 = rotationQuaternion(PITHIRD,PITHIRD,0.0)
    assert approximate_equal(rq1, initQuaternion(0.866025,0.0,0.5,0.0), places=2) 
    assert approximate_equal(rq2, initQuaternion(0.75,-0.25,0.4330127,0.4330127), places=2) 

    

test "rotation from yaw, pitch, roll":
    let v = (x:10.0, y:20.0, z:30.0)
    let rq1 = rotationQuaternion(0.0,PITHIRD,0.0)
    let rv1 = rotateVector(rq1, v)
    let rf1 : vector3d = (x: 30.98076211353316, y: 20.0, z: 6.339745962155618)
    assert approximate_equal(rv1,rf1, places=12)

    let rq2 = rotationQuaternion(PITHIRD,PITHIRD,0.0)
    let rv2 = rotateVector(rq2, v)
    let rf2 : vector3d = (x: -1.830127018922187, y: 36.83012701892219, z: 6.339745962155618)
    
    assert approximate_equal(rv2,rf2, places=12)
    
