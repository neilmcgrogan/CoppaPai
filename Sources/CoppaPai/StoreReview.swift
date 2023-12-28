//
//  StoreReview.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/9/23.
//

import StoreKit
import SwiftUI

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct StoreReview {
    public func requestReview() {
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

extension UIApplication {
    @available(iOS 13.0, *)
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}

@available(iOS 13.0, *)
extension Color {
    static var menuTitle = Color(red: 39/255, green: 36/255, blue: 45/255)
}

@available(iOS 13.0, *)
public struct TestView: View {
    
    public init() {}
    
    public var body: some View {
        Text("Test")
    }
}
