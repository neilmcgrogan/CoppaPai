//
//  LapalaDefinitions.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/24/23.
//

import Foundation
import SwiftUI

let delayConst = 0.25

/// Stores points cw from top let
let locations: [CGPoint] = [
    CGPoint(x: 0.3, y: 0),
    CGPoint(x: 1, y: 0),
    CGPoint(x: 1.7, y: 0),
    
    CGPoint(x: 2, y: 0.3),
    CGPoint(x: 2, y: 1),
    CGPoint(x: 2, y: 1.7),

    CGPoint(x: 1.7, y: 2),
    CGPoint(x: 1, y: 2),
    CGPoint(x: 0.3, y: 2),
    
    CGPoint(x: 0, y: 1.7),
    CGPoint(x: 0, y: 1),
    CGPoint(x: 0, y: 0.3)
]

let offsetCoefficient = 25

let pointOffset: [CGPoint] = [
    CGPoint(x: 0, y: -offsetCoefficient),
    CGPoint(x: 0, y: -offsetCoefficient),
    CGPoint(x: 0, y: -offsetCoefficient),
    
    CGPoint(x: offsetCoefficient, y: 0),
    CGPoint(x: offsetCoefficient, y: 0),
    CGPoint(x: offsetCoefficient, y: 0),

    CGPoint(x: 0, y: offsetCoefficient),
    CGPoint(x: 0, y: offsetCoefficient),
    CGPoint(x: 0, y: offsetCoefficient),
    
    CGPoint(x: -offsetCoefficient, y: 0),
    CGPoint(x: -offsetCoefficient, y: 0),
    CGPoint(x: -offsetCoefficient, y: 0),
]
