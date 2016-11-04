//
//  CGPointExtension.swift
//  demoApp
//
//  Created by David Crooks on 23/01/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//

import Foundation
import UIKit

func dot(left: CGPoint, right: CGPoint) -> CGFloat {
    
    return  left.x*right.x +  left.y*right.y
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    
    return CGPoint(x: left.x+right.x, y: left.y+right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    
    return CGPoint(x: left.x-right.x, y: left.y-right.y)
}

func *(left: CGFloat, right: CGPoint) -> CGPoint {
    
    return CGPoint(x: left*right.x, y:left*right.y)
}

func *(left: CGPoint, right: CGAffineTransform) -> CGPoint {
    
    return CGPointApplyAffineTransform(left, right)
}

func *(left: CGPoint, right: CATransform3D) -> CGPoint {
    
    return left.applyTransform3D(transform: right)
}


public extension CGPoint {
    public  func add( p:CGPoint) -> CGPoint {
        var v = self
        v.x = v.x + p.x
        v.y = v.y + p.y
        return v
    }
    
    public  func minus( p:CGPoint) -> CGPoint {
        var v = self
        v.x = v.x - p.x
        v.y = v.y - p.y
        return v
    }
    public  func mult( lambda:CGFloat) -> CGPoint {
        var v = self
        v.x = v.x * lambda
        v.y = v.y * lambda
        return v
    }

    public func distanceTo(p: CGPoint) -> CGFloat {
        let q = self
        return  q.minus(p).length()
    }
    
    public func dot(q:CGPoint) -> CGFloat {
        let p = self
        return p.x * q.x + p.y * q.y
    }
    
    public func cross(q:CGPoint) -> CGFloat {
        let p = self
        //CHECK SIGN!
        return p.x * q.y - p.y * q.x
    }
    
    public func angle(q:CGPoint) -> CGFloat {
        let c = self.dot(q) / (self.length()    * q.length())
        return acos(c)
    }
    
    
    //The range of the angle is -π to π; an angle of 0 points to the right.
    public var angle: CGFloat {
        return atan2(y, x)
    }
    
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    public func unitVector() -> CGPoint {
        let l = length()
        return CGPoint(x: x/l, y: y/l)
    }
    
    public func lengthSquared() -> CGFloat {
        return x*x + y*y
    }
    
    public func midPoint(point: CGPoint) -> CGPoint {
        let q = self
        let p = point
        var v = p.minus(q)
        v = v.mult(0.5)
        
        return  q.add(v)
    }
    /*
    public func glkVector2() -> GLKVector2 {
        return GLKVector2Make(Float(x),Float( y))
    }
    */ 
    public func applyTransform3D(transform M: CATransform3D) -> CGPoint {
        let p = self
        var q = CGPointZero
        let pz:CGFloat = 1.0
        //let pw = p.x * p.y
        let pw:CGFloat = 1.0
        
        let  w = M.m14*p.x + M.m24*p.y + M.m34*pz + M.m44*pw
       q.x = (M.m11*p.x + M.m21*p.y + M.m31*pz + M.m41*pw)/w
        q.y = (M.m12*p.x + M.m22*p.y + M.m32*pz + M.m42*pw)/w
        
       //   q.x = M.m11*p.x + M.m12*p.y + M.m13*pz + M.m14*pw
        //  q.y = M.m21*p.x + M.m22*p.y + M.m23*pz + M.m24*pw
        return q
    }
    
    
    var isValid:Bool {
        if isnan(self.x) || isnan(self.y) {
            return false
        }
        return true
    }
}

/*
/*
* Copyright (c) 2013-2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import CoreGraphics
import SpriteKit

public extension CGPoint {
/**
* Creates a new CGPoint given a CGVector.
*/
public init(vector: CGVector) {
self.init(x: vector.dx, y: vector.dy)
}

/**
* Given an angle in radians, creates a vector of length 1.0 and returns the
* result as a new CGPoint. An angle of 0 is assumed to point to the right.
*/
public init(angle: CGFloat) {
self.init(x: cos(angle), y: sin(angle))
}

/**
* Adds (dx, dy) to the point.
*/
public mutating func offset(#dx: CGFloat, dy: CGFloat) -> CGPoint {
x += dx
y += dy
return self
}

/**
* Returns the length (magnitude) of the vector described by the CGPoint.
*/
public func length() -> CGFloat {
return sqrt(x*x + y*y)
}

/**
* Returns the squared length of the vector described by the CGPoint.
*/
public func lengthSquared() -> CGFloat {
return x*x + y*y
}

/**
* Normalizes the vector described by the CGPoint to length 1.0 and returns
* the result as a new CGPoint.
*/
func normalized() -> CGPoint {
let len = length()
return len>0 ? self / len : CGPoint.zeroPoint
}

/**
* Normalizes the vector described by the CGPoint to length 1.0.
*/
public mutating func normalize() -> CGPoint {
self = normalized()
return self
}

/**
* Calculates the distance between two CGPoints. Pythagoras!
*/
public func distanceTo(point: CGPoint) -> CGFloat {
return (self - point).length()
}

/**
* Returns the angle in radians of the vector described by the CGPoint.
* The range of the angle is -π to π; an angle of 0 points to the right.
*/
public var angle: CGFloat {
return atan2(y, x)
}
}

/**
* Adds two CGPoint values and returns the result as a new CGPoint.
*/
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/**
* Increments a CGPoint with the value of another.
*/
public func += (inout left: CGPoint, right: CGPoint) {
left = left + right
}

/**
* Adds a CGVector to this CGPoint and returns the result as a new CGPoint.
*/
public func + (left: CGPoint, right: CGVector) -> CGPoint {
return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

/**
* Increments a CGPoint with the value of a CGVector.
*/
public func += (inout left: CGPoint, right: CGVector) {
left = left + right
}

/**
* Subtracts two CGPoint values and returns the result as a new CGPoint.
*/
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/**
* Decrements a CGPoint with the value of another.
*/
public func -= (inout left: CGPoint, right: CGPoint) {
left = left - right
}

/**
* Subtracts a CGVector from a CGPoint and returns the result as a new CGPoint.
*/
public func - (left: CGPoint, right: CGVector) -> CGPoint {
return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

/**
* Decrements a CGPoint with the value of a CGVector.
*/
public func -= (inout left: CGPoint, right: CGVector) {
left = left - right
}

/**
* Multiplies two CGPoint values and returns the result as a new CGPoint.
*/
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/**
* Multiplies a CGPoint with another.
*/
public func *= (inout left: CGPoint, right: CGPoint) {
left = left * right
}

/**
* Multiplies the x and y fields of a CGPoint with the same scalar value and
* returns the result as a new CGPoint.
*/
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

/**
* Multiplies the x and y fields of a CGPoint with the same scalar value.
*/
public func *= (inout point: CGPoint, scalar: CGFloat) {
point = point * scalar
}

/**
* Multiplies a CGPoint with a CGVector and returns the result as a new CGPoint.
*/
public func * (left: CGPoint, right: CGVector) -> CGPoint {
return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}

/**
* Multiplies a CGPoint with a CGVector.
*/
public func *= (inout left: CGPoint, right: CGVector) {
left = left * right
}

/**
* Divides two CGPoint values and returns the result as a new CGPoint.
*/
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

/**
* Divides a CGPoint by another.
*/
public func /= (inout left: CGPoint, right: CGPoint) {
left = left / right
}

/**
* Divides the x and y fields of a CGPoint by the same scalar value and returns
* the result as a new CGPoint.
*/
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

/**
* Divides the x and y fields of a CGPoint by the same scalar value.
*/
public func /= (inout point: CGPoint, scalar: CGFloat) {
point = point / scalar
}

/**
* Divides a CGPoint by a CGVector and returns the result as a new CGPoint.
*/
public func / (left: CGPoint, right: CGVector) -> CGPoint {
return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}

/**
* Divides a CGPoint by a CGVector.
*/
public func /= (inout left: CGPoint, right: CGVector) {
left = left / right
}

/**
* Performs a linear interpolation between two CGPoint values.
*/
public func lerp(#start: CGPoint, #end: CGPoint, #t: CGFloat) -> CGPoint {
return start + (end - start) * t
}

*/