//
//  Styles.swift
//  Lapala
//
//  Created by Neil McGrogan on 10/11/23.
//

import SwiftUI

@available(iOS 14.0, *)
extension View {
    public func outlined() -> some View {
        self
            .background(LinearGradient(colors: [Color.white.opacity(0.7), Color.white.opacity(0.35)], startPoint: .bottom, endPoint: .top))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                .stroke(LinearGradient(colors: [Color.white.opacity(0.3), Color.white.opacity(0.025)], startPoint: .bottom, endPoint: .top), lineWidth: 4)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .shadow(color: .black.opacity(0.1), radius: 80, x: 0, y: 100)
            .shadow(color: .black.opacity(0.14), radius: 10, x: 0, y: 12.5)
    }
    
    public func sectionTitle() -> some View {
        self
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .padding(.bottom, -4)
    }
    
    public func onBackSwipe(perform action: @escaping () -> Void) -> some View {
        gesture(
            DragGesture()
                .onEnded({ value in
                    if value.startLocation.x < 50 && value.translation.width > 80 {
                        action()
                    }
                })
        )
    }
    
    public func button(selectable: Bool) -> some View {
        self
            .font(.title3)
            .foregroundColor(selectable ? Color.primary : Color.gray)
            .padding(7.5)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectable ? Color.primary : Color.gray, lineWidth: 2)
            )
    }
    
    public func titleButton() -> some View {
        self
            .font(.title)
            .shadow(radius: 5)
            .foregroundColor(.white)
            .padding(.horizontal)
    }
}

struct ScaleButton: ButtonStyle {
    @available(iOS 13.0, *)
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1)
    }
}
