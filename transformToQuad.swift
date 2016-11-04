//
//  transformToQuad.swift
//  PaintLab
//
//  Created by David Crooks on 20/03/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//
import UIKit
import Foundation

func CATransform3DRectToQuad(rect:CGRect, quad:DCQuad) -> CATransform3D {
 
    let X = rect.origin.x
    let Y = rect.origin.y
    let W = rect.size.width
    let H = rect.size.height
    
    let x1 = quad.a.x
    let x2 = quad.b.x
    let x3 = quad.d.x
    let x4 = quad.c.x
    
    let y1 = quad.a.y
    let y2 = quad.b.y
    let y3 = quad.d.y
    let y4 = quad.c.y
    
    let y21 = quad.b.y - quad.a.y    //y2a - y1a
    let y32 = quad.d.y - quad.b.y    //y3a - y2a
    let y43 = quad.c.y - quad.d.y    //y4a - y3a
    let y14 = quad.a.y - quad.c.y    //y1a - y4a
    let y31 = quad.d.y - quad.a.y    //y3a - y1a
    let y42 = quad.c.y - quad.b.y    //y4a - y2a
    
    let a = -H*(x2*x3*y14 + x2*x4*y31 - x1*x4*y32 + x1*x3*y42)
    let b = W*(x2*x3*y14 + x3*x4*y21 + x1*x4*y32 + x1*x2*y43)
    let c1 = -W*Y*(x2*x3*y14 + x3*x4*y21 + x1*x4*y32 + x1*x2*y43)
    let c = H*X*(x2*x3*y14 + x2*x4*y31 - x1*x4*y32 + x1*x3*y42) - H*W*x1*(x4*y32 - x3*y42 + x2*y43) + c1
    
    let d = H*(-x4*y21*y3 + x2*y1*y43 - x1*y2*y43 - x3*y1*y4 + x3*y2*y4)
    let e = W*(x4*y2*y31 - x3*y1*y42 - x2*y31*y4 + x1*y3*y42)
    let f1 = -H*X*(x4*y21*y3 - x2*y1*y43 + x3*(y1 - y2)*y4 + x1*y2*(-y3 + y4))
    let f2 =  H*x2*y1*y43 + x2*Y*(y1 - y3)*y4
    let f3 =  x1*Y*y3*(-y2 + y4)
    let f = -(W*(x4*(Y*y2*y31 + H*y1*y32) - x3*(H + Y)*y1*y42 + f2 + f3) + f1)
    
    let g = H*(x3*y21 - x4*y21 + (-x1 + x2)*y43)
    let h = W*(-x2*y31 + x4*y31 + (x1 - x3)*y42)
    let i1 =  W*(-(x3*y2) + x4*y2 + x2*y3 - x4*y3 - x2*y4 + x3*y4)
    let i2 = H*(X*(-(x3*y21) + x4*y21 + x1*y43 - x2*y43) + i1 )
    var i = W*Y*(x2*y31 - x4*y31 - x1*y42 + x3*y42) + i2
    
    let epsilon = CGFloat(0.0001);
    if fabs(i) < epsilon {
        i = epsilon * (i > 0 ? 1 : -1);
    }
    
    return CATransform3D(m11: a/i, m12: d/i, m13: 0, m14: g/i, m21: b/i, m22: e/i, m23: 0, m24: h/i, m31: 0, m32: 0, m33: 1, m34: 0, m41: c/i, m42: f/i, m43: 0, m44: 1.0)
}

