//
//  Spring.swift
//  Dordle
//
//  Created by Neil McGrogan on 12/15/22.
//

import SwiftUI

@available(iOS 13.0, *)
struct SpringView: View {
    
    @Binding var animateTrigger: Bool
    @State private var animation = false
    
    let angle = 10.0
    let glareWidth = 40.0
    let oppacity = 0.01
    
    func animate() {
        withAnimation(.timingCurve(0.6, 0.17, 0.59, 1.0, duration: 0.5).delay(0.25)){
            animation = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            animation = false
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            let angleRadians = angle * .pi / 180
            let fullHeight = ((geometry.size.height / 2) / (sin((.pi / 2) - angleRadians))) * 2 + 40
            let offset = (fullHeight / 2) * tan(angleRadians)
            
            if animateTrigger {
                Rectangle()
                    .fill(Color.clear.opacity(oppacity))
                    .frame(width: glareWidth, height: fullHeight)
                    .rotationEffect(Angle(radians: angleRadians), anchor: .center)
                    .offset(x: animation ? geometry.size.width + offset : -glareWidth - offset, y: -20)
                    .blendMode(.colorDodge)
            } else {
                Rectangle()
            }
        }
        /// Only animates once
        .onAppear() {
            animate()
        }
        /*
        .onReceive(timer) { _ in
            
            if step == 0 {
                animate()
            }
            self.step += 1
            if step % 3 == 0 {
                animate()
            }
        }*/
    }
}

@available(iOS 13.0, *)
struct SpringCard: ViewModifier {
    @State private var glareTrigger = false
    @State private var cardAngle = 0.0
    @State private var step = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let animateTrigger: Bool
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            animateCardAngle(-8.5, 0.2)
            if animateTrigger {
                glareTrigger.toggle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            animateCardAngle(0.2, 8.5)
        }
    }
    
    func animateCardAngle(_ angle: Double,_ duration: Double) {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.4, blendDuration: 0.2)) {
            cardAngle = angle
        }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                SpringView(animateTrigger: $glareTrigger)
            )
            .clipped()
            .rotation3DEffect(.degrees(cardAngle), axis: (x: 0, y: -1, z: 0))
            .onReceive(timer) { _ in
                step += 1
                if step % 3 == 0 || step == 0 {
                    startAnimation()
                }
            }
    }
}

@available(iOS 13.0, *)
extension View {
    public func springEffect(animationTrigger: Bool) -> some View {
        self.modifier(SpringCard(animateTrigger: animationTrigger))
    }
}
