//
//  Styles.swift
//  Lapala
//
//  Created by Neil McGrogan on 10/11/23.
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
extension View {
    public func outlined(dark: Bool) -> some View {
        if dark {
            self
                .background(LinearGradient(colors: [Color.gray.opacity(0.80), Color.black], startPoint: .bottom, endPoint: .top))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .shadow(color: .white.opacity(0.1), radius: 80, x: 0, y: 100)
                .shadow(color: .white.opacity(0.14), radius: 10, x: 0, y: 12.5)
        } else {
            self
                .background(LinearGradient(colors: [Color.white.opacity(0.7), Color.white.opacity(0.35)], startPoint: .bottom, endPoint: .top))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .shadow(color: .black.opacity(0.1), radius: 80, x: 0, y: 100)
                .shadow(color: .black.opacity(0.14), radius: 10, x: 0, y: 12.5)
        }
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
    
    public func defaultPopUp() -> some View {
        self
            .foregroundColor(Color(UIColor.systemBackground))
            .font(.title2)
            .bold()
            .padding()
            .padding(.horizontal, 5)
            .background(Color.primary)
            .cornerRadius(20)
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
            .foregroundColor(Color.primary)
            .padding(.horizontal)
    }
}

public struct ScaleButton: ButtonStyle {
    @available(iOS 13.0, *)
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.90 : 1)
    }
}
