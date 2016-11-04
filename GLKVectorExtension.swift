//
//  GLKVectorExtension.swift
//  PaintLab
//
//  Created by David Crooks on 29/02/2016.
//  Copyright © 2016 David Crooks. All rights reserved.
//

import Foundation
import UIKit

func +(left: GLKVector2, right: GLKVector2) -> GLKVector2 {
    return GLKVector2Add(left, right)
}

func -(left: GLKVector2, right: GLKVector2) -> GLKVector2 {
    
    return GLKVector2Subtract(left, right)
}


public extension GLKVector2 {
    func cgPoint() -> CGPoint {
        return CGPointMake(CGFloat(x), CGFloat(y))
    }
}