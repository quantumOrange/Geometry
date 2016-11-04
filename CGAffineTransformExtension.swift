//
//  CGAffineTransformExtension.swift
//  demoApp
//
//  Created by David Crooks on 23/01/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//

import Foundation
import UIKit
import GLKit

func *(left: CGAffineTransform, right: CGAffineTransform) -> CGAffineTransform {
    return CGAffineTransformConcat(left,right)
}


public extension CGAffineTransform {
    
    static func rotationAboutPoint( angle:CGFloat,  point:CGPoint) -> CGAffineTransform {
        let Tminus = CGAffineTransformMakeTranslation(-point.x, -point.y)
        let R = CGAffineTransformMakeRotation(angle)
        let Tplus = CGAffineTransformMakeTranslation(point.x, point.y)
        
        
        return Tminus * R  * Tplus
        //return CGAffineTransformConcat( Tminus  ,CGAffineTransformConcat( R ,Tplus  ))
    }
    
    static func stretch(scale:CGFloat, angle:CGFloat, aboutPoint p:CGPoint) -> CGAffineTransform {
        
        let Tminus = CGAffineTransformMakeTranslation(-p.x, -p.y)
        let Tplus = CGAffineTransformMakeTranslation(p.x, p.y)
        let Rminus = CGAffineTransformMakeRotation(-angle)
        let Rplus = CGAffineTransformMakeRotation(angle)
        let S = CGAffineTransformMakeScale( scale,1.0)
        
        
        return  Tminus * Rminus * S * Rplus * Tplus
    }
    
    var angle:CGFloat {
        get {
            return atan2(self.b, self.a)
        }
        set {
            let T = self.translation
            let S = self.scale
            let R = CGAffineTransformMakeRotation(newValue)
            
            self =   T * S * R
        }
    }
    
    var rotation:CGAffineTransform {
        return CGAffineTransformMakeRotation(self.angle)
    }

    var translation:CGAffineTransform {
        return CGAffineTransformMakeTranslation(self.tx,self.ty)
    }
    
    var scale:CGAffineTransform {
       //return CGAffineTransformMakeScale(sqrt(self.a*self.a+self.b*self.b), sqrt(self.c*self.c+self.d*self.d))
        return CGAffineTransformMakeScale(self.xSscale, self.yScale)
    }
    
    
    
    var xSscale:CGFloat {
        let t = self
        return sqrt(t.a * t.a + t.c * t.c);
    }
            
    var yScale:CGFloat {
            let t = self
        return sqrt(t.b * t.b + t.d * t.d)
    }
    
}