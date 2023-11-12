//
//  MenuViewStyle.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 11/12/23.
//

import SwiftUI

@available(iOS 14.0, *)
extension View {
    public func menuViewStyle() -> some View {
        self
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}

@available(iOS 13.0, *)
public struct BlurView: UIViewRepresentable {
    public typealias UIViewType = UIView
    
    var style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style) {
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        // useful for animations when our views change
    }
}

@available(iOS 13.0, *)
extension Color {
    public static let metalBlue = Color(red: 169 / 255, green: 187 / 255, blue: 212 / 255)
}
