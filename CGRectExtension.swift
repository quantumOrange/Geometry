//
//  CGRectExtension.swift
//  demoApp
//
//  Created by David Crooks on 23/01/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//

import Foundation
import UIKit


public extension CGRect     {
    enum quadrant {
        case top,bottom,left,right,topLeft,topRight,bottomLeft,bottomRight,inside
    }
    
    func pointInQuadrant(p:CGPoint) -> quadrant {
        let o = origin
        let farCorner = o.add(CGPoint(x: size.width,y: size.height))
        
        if contains(p){
            return .inside
        }
        else if p.x < origin.x {
            //Left
            if p.y < origin.y {
                //Top
                return .topLeft
            }
            else if p.y > farCorner.y {
                //Bootom
                return .bottomLeft
            }
            else {
                //Middle
                return .left
            }
        }
        else if p.x > farCorner.x{
            //Right
            if p.y < origin.y {
                //Top
                return .topRight
            }
            else if p.y > farCorner.y {
                //Bottom
                return .bottomRight
            }
            else {
                //Middle
                return .right
            }
        }
        else
        {
            //Middle
            if p.y < origin.y {
                //Top
                return .top
            }
            else if p.y > farCorner.y {
                //Bottom
                return .bottom
            }
            else {
                //Middle
                return .inside
            }
        }
    }
    
    var bottomRight:CGPoint {
        get {
            return CGPoint(x: origin.x   +  size.width, y: origin.y +  size.height)
        }
        set {
            origin = CGPoint(x: newValue.x - size.width, y: newValue.y - size.height)
        }
    }
    
    var topRight:CGPoint {
        get {
            return CGPoint(x: origin.x   +  width, y: origin.y )
        }
        set {
            origin = CGPoint(x: newValue.x - size.width, y: newValue.y)
        }
    }
    
    var bottomLeft:CGPoint {
        get {
            return CGPoint(x: origin.x  , y: origin.y +  size.height)
        }
        set {
            origin = CGPoint(x: newValue.x, y: newValue.y - size.height)
        }
    }
    
    var topLeft:CGPoint {
        get {
            return origin
        }
        set {
            origin = newValue
        }
    }
    
    var center:CGPoint {
        get {
            return CGPoint(x: origin.x   + 0.5*size.width, y: origin.y +  0.5*size.height)
        }
        set {
            origin = CGPoint(x: newValue.x - 0.5*size.width, y: newValue.y - 0.5*size.height)
        }
    }
    
    var topCenter:CGPoint {
        get {
            return CGPoint(x: origin.x   + 0.5*size.width, y: origin.y)
        }
        set {
            origin = CGPoint(x: newValue.x - 0.5*size.width, y: newValue.y)
        }
    }
    
    var bottomCenter:CGPoint {
        get {
            return CGPoint(x: origin.x   + 0.5*size.width, y: origin.y +  size.height)
        }
        set {
            origin = CGPoint(x: newValue.x - 0.5*size.width, y: newValue.y - size.height)
        }
    }
    var leftCenter:CGPoint {
        get {
            return CGPoint(x: origin.x , y: origin.y +  0.5*size.height)
        }
        set {
            origin = CGPoint(x: newValue.x , y: newValue.y - 0.5*size.height)
        }
    }
    var rightCenter:CGPoint {
        get {
            return CGPoint(x: origin.x   + size.width, y: origin.y +  0.5*size.height)
        }
        set {
            origin = CGPoint(x: newValue.x - size.width, y: newValue.y - 0.5*size.height)
        }
    }
    
    func applyTransform(transform:CGAffineTransform) -> DCQuad {
        let quad = DCQuad(rect: self)
        return quad.applyTransform(transform)
    }
    func applyTransform3D(transform:CATransform3D) -> DCQuad {
        let quad = DCQuad(rect: self)
        return quad.applyTransform3D(transform)
    }

}