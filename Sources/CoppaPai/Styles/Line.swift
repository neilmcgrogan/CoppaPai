//
//  Line.swift
//  Lapala
//
//  Created by Neil McGrogan on 10/3/23.
//

import SwiftUI

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    /*var animatableData: AnimatablePair<CGPoint, CGPoint> {
     get { AnimatablePair(from, to) }
     set {
     from = newValue.first
     to = newValue.second
     }
     }*/
    
    @available(iOS 13.0, *)
    public func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}
