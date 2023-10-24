//
//  AnimatingLine.swift
//  Lapala
//
//  Created by Neil McGrogan on 10/8/23.
//

import SwiftUI

@available(iOS 13.0, *)
struct Trace: Shape {
    let points: [Int]
    let geo: GeometryProxy
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for point in points {
            if path.isEmpty {
                path.move(to: CGPoint(x: locations[point].x * geo.size.width / 2, y: locations[point].y * geo.size.height / 2))
            } else {
                path.addLine(to: CGPoint(x: locations[point].x * geo.size.width / 2, y: locations[point].y * geo.size.height / 2))
            }
        }
        
        return path
    }
}

@available(iOS 14.0, *)
public struct AnimatingLine: View {
    @State private var percentage: CGFloat = 0
    let geo: GeometryProxy
    
    let points: [Int]
    
    @State private var timeOffset = 0.0
    
    public init(geo: GeometryProxy, points: [Int]) {
        self.geo = geo
        self.points = points
    }
    
    public var body: some View {
        ZStack {
            Trace(points: points, geo: geo)
                .trim(from: 0, to: percentage)
                .stroke(Color.primary_pink, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .animation(.easeIn(duration: self.timeOffset), value: percentage)
                .opacity(self.percentage == 0 ? 0 : 1)
                .onChange(of: points.count) { change in
                    self.percentage = 1.0
                    self.timeOffset = Double(change) * delayConst
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.20 + timeOffset) {
                        self.percentage = 0
                    }
                }
        }
    }
}

