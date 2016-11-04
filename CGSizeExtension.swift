//
//  CGSizeExtension.swift
//  demoApp
//
//  Created by David Crooks on 23/01/2015.
//  Copyright (c) 2015 David Crooks. All rights reserved.
//

import Foundation
import UIKit

public extension CGSize {
    var center:CGPoint {
        return CGPoint(x: width*0.5, y: height*0.5)
    }
}