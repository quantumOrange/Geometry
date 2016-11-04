//
//  geometry.swift
//  swiftDemo
//
//  Created by David Crooks on 04/01/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//

import Foundation
import UIKit


func *(left: DCTriangle, right: CGAffineTransform) -> DCTriangle {
    
    var newTriangle = DCTriangle()
    
    newTriangle.a = left.a * right
    newTriangle.b = left.b * right
    newTriangle.c = left.c * right
    
    return newTriangle
}

func *(left: DCQuad, right: CGAffineTransform) -> DCQuad {
    
    var newQuad = DCQuad()
    
    newQuad.a = left.a * right
    newQuad.b = left.b * right
    newQuad.c = left.c * right
    newQuad.d = left.d * right
    
    return newQuad
}


public struct DCTriangle:CustomStringConvertible {
    
    public var description: String { get { return "Triangle A:\(a) B:\(b) C:(\(c) " } }
    
    var a = CGPointZero
    var b = CGPointZero
    var c = CGPointZero
    
    init() {
        
    }
    
    init(A:CGPoint,B:CGPoint,C:CGPoint) {
        a = A
        b = B
        c = C
    }
    
    var area:CGFloat {
        return  abs(0.5*( a.x*(b.y - c.y) + b.x*(c.y - a.y) + c.x*(a.y - b.y) ))
    }
    
    
    func containsPoint(p:CGPoint) ->Bool {
        // Compute vectors
        let v0 = c - a
        let v1 = b - a
        let v2 = p - a
        
        // Compute dot products
       
        let dot00 = dot(v0, right: v0)
        let dot01 = dot(v0, right: v1)
        let dot02 = dot(v0, right: v2)
        let dot11 = dot(v1, right: v1)
        let dot12 = dot(v1, right: v2)
        
        // Compute barycentric coordinates
       let  invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01)
       let  u = (dot11 * dot02 - dot01 * dot12) * invDenom
       let  v = (dot00 * dot12 - dot01 * dot02) * invDenom
        
        // Check if point is in triangle
        return (u > 0) && (v > 0) && (u + v < 1)
    }

}

public struct DCQuad:CustomStringConvertible {
    
    public var description: String { get { return "Quad A:\(a) B:\(b) C:(\(c) D:\(d)  centroid:\(centroid)" } }
    
    var a = CGPointZero
    var b = CGPointZero
    var c = CGPointZero
    var d = CGPointZero
    //midpoints
    var ab:CGPoint {
        return a.midPoint(b)
    }
    
    var bc:CGPoint {
        return b.midPoint(c)
    }
    
    var cd:CGPoint {
        return c.midPoint(d)
    }
    
    var da:CGPoint {
        return d.midPoint(a)
    }
    
    //Diagonal midpoints
    var ac:CGPoint {
        return a.midPoint(c)
    }
    
    var db:CGPoint {
        return d.midPoint(b)
    }
    var center:CGPoint? {
        let lineAC = DCLineSegment(start: a,end: c)
        let lineDB = DCLineSegment(start: d,end: b)
        //a quadrilatteral is convex iff it diagonal line segments iteresect
        return lineAC.intesectsLineSegment(lineDB)
    }
    
    var centroid:CGPoint {
       //The centroid is the midpoint of the line joining the midpoints of the diagonals:
        return ac.midPoint(db)
    }
    
    
    //line segment vecotrs
    var AB:CGPoint {
        return b.minus(a)
    }
    var BC:CGPoint {
        return c.minus(b)
    }
    var CD:CGPoint {
        return d.minus(c)
    }
    var DA:CGPoint {
        return a.minus(d)
    }

    var BA:CGPoint {
        return a.minus(b)
    }
    var CB:CGPoint {
        return b.minus(c)
    }
    var DC:CGPoint {
        return c.minus(d)
    }
    var AD:CGPoint {
        return d.minus(a)
    }
    
    //interior angles
    var angleA:CGFloat {
       return AB.angle(AD)
    }
    
    var angleB:CGFloat {
        return BC.angle(BA)
    }
    
    var angleC:CGFloat {
        return CD.angle(CB)
    }
    
    var angleD:CGFloat {
        return DA.angle(DC)
    }
    
    var isConvex:Bool  {
        let lineAC = DCLineSegment(start: a,end: c)
        let lineDB = DCLineSegment(start: d,end: b)
        //a quadrilatteral is convex iff it diagonal line segments iteresect
        if let _ = lineAC.intesectsLineSegment(lineDB){
            return true
        }
        else
        {
            return false
        }
    }
    
    var area:CGFloat {
        let t1 = DCTriangle(A: a, B: b, C: c)
        let t2 = DCTriangle(A: b, B: c, C: d)
        return t1.area + t2.area
    }
    
    func containsPoint(p:CGPoint) ->Bool {
        //this is only valid if the quad is convex
        
       
        
        
        let in1 = DCTriangle(A: a, B: b, C: c).containsPoint(p)
        let in2 = DCTriangle(A: b, B: c, C: d).containsPoint(p)
        let in3 = DCTriangle(A: c, B: d, C: a).containsPoint(p)
        let in4 = DCTriangle(A: d, B: a, C: b).containsPoint(p)
        
        
      //  let inTrinagle = in1 || in2 || in3 || in4
        return in1 || in2 || in3 || in4

    }
    
    init(){
        
    }
    
    init(rect:CGRect) {
        a = rect.topLeft
        b = rect.topRight
        c = rect.bottomRight
        d = rect.bottomLeft
    }
    
    func applyTransform(transform:CGAffineTransform) -> DCQuad {
        var quad = DCQuad()
        quad.a = CGPointApplyAffineTransform(self.a, transform)
        quad.b = CGPointApplyAffineTransform(self.b, transform)
        quad.c = CGPointApplyAffineTransform(self.c, transform)
        quad.d = CGPointApplyAffineTransform(self.d, transform)
        return quad
    }
    
    public func applyTransform3D(transform: CATransform3D) -> DCQuad {
        var Q = self
        Q.a = Q.a.applyTransform3D(transform:transform)
        Q.b = Q.b.applyTransform3D(transform:transform)
        Q.c = Q.c.applyTransform3D(transform:transform)
        Q.d = Q.d.applyTransform3D(transform:transform)
        return Q
    }
    var isValid:Bool {
        return a.isValid && b.isValid && c.isValid && d.isValid
    }
    
    enum QuadCorner {
        case A,B,C,D, None
        func description() -> String {
            switch self {
                case .A:
                    return "A"
                case .B:
                    return "B"
                case .C:
                    return "C"
                case .D:
                    return "D"
                case .None:
                    return "None"
            }
        }
    }
var selectedPoint:CGPoint {
        get {
            switch selectedQuadCorner {
                case .A:
                    return a
                case .B:
                    return b
                case .C:
                    return c
                case .D:
                    return d
                case .None:
                    return CGPointZero
                }
        }
        set {
            switch selectedQuadCorner {
            case .A:
                a = newValue
            case .B:
                b = newValue
            case .C:
                c = newValue
            case .D:
                d = newValue
            case .None:
                break
            }
        }
    }

    var selectedQuadCorner = QuadCorner.None
}


extension CATransform3D {
    
    func transpose() -> CATransform3D {
        var transform = self
        
       
        transform.m12 = self.m21
        transform.m13 = self.m31
        transform.m14 = self.m41
        transform.m21 = self.m12
        
        transform.m23 = self.m32
        transform.m24 = self.m42
        transform.m31 = self.m13
        transform.m32 = self.m23
       
        transform.m34 = self.m43
        transform.m41 = self.m14
        transform.m42 = self.m24
        transform.m43 = self.m34
        
        
        return transform
    
    }
    
    func print() {
        let M = self
        Swift.print(" \(M.m11), \(M.m12), \(M.m13), \(M.m14)")
        Swift.print(" \(M.m21), \(M.m22), \(M.m23), \(M.m24)")
        Swift.print(" \(M.m31), \(M.m32), \(M.m33), \(M.m34)")
        Swift.print(" \(M.m41), \(M.m42), \(M.m43), \(M.m44)")
    }
}



public struct DCLine {
    
    var s = CGPointZero
    var e = CGPointZero
    
    var r:CGPoint {
        return e.minus(s)
    }
    
    func point(t:CGFloat) -> CGPoint {
        return s.add(r.mult(t))
    }
    
    func intesectsLineSegment(line:DCLineSegment) -> CGPoint? {
        
        var intersectionPoint:CGPoint?
        
        let p = self
        let q = line
        let denominator = (p.r).cross(q.r)
        if denominator != 0 {
            let t = (q.s.minus(p.s)).cross(q.r)/denominator
            intersectionPoint = self.point(t)
        }
        return intersectionPoint
    }
    
    
    init(start:CGPoint, end:CGPoint) {
        s = start
        e = end
    }
}

public extension UIView {
    func convertQuad(quad:DCQuad,fromView:UIView?) -> DCQuad {
        var newQuad = DCQuad()
        newQuad.a = convertPoint(quad.a, fromView: fromView)
        newQuad.b = convertPoint(quad.b, fromView: fromView)
        newQuad.c = convertPoint(quad.c, fromView: fromView)
        newQuad.d = convertPoint(quad.d, fromView: fromView)
        return newQuad
    }
    func convertQuad(quad:DCQuad,toView:UIView?) -> DCQuad {
        var newQuad = DCQuad()
        newQuad.a = convertPoint(quad.a, toView: toView)
        newQuad.b = convertPoint(quad.b, toView: toView)
        newQuad.c = convertPoint(quad.c, toView: toView)
        newQuad.d = convertPoint(quad.d, toView: toView)
        return newQuad
    }
}
public struct DCLineSegment {
    
    var s = CGPointZero
    var e = CGPointZero
    
    var r:CGPoint {
        return e.minus(s)
    }
    
    func point(t:CGFloat) -> CGPoint {
        return s.add(r.mult(t))
    }
    
    func intesectsLineSegment(line:DCLineSegment) -> CGPoint? {
        
        var intersectionPoint:CGPoint?
        
        let p = self
        let q = line
        let denominator = (p.r).cross(q.r)
        if denominator  != 0 {
            let t = (q.s.minus(p.s)).cross(q.r)/denominator
            let u = (q.s.minus(p.s)).cross(p.r)/denominator
            if ((t > 0.0 && t < 1.0) &&  (u > 0.0 && u < 1.0)) {
                intersectionPoint = self.point(t)
            }
        }
        
        
        return intersectionPoint
    }
    
    
    init(start:CGPoint, end:CGPoint) {
        s = start
        e = end
    }
    
    
    
}
