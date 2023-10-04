//
//  Styles.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 9/25/23.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS 15.0, *)
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
    
}
