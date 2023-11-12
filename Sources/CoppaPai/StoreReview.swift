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

@available(iOS 15.0, *)
public struct AskForReview: View {
    public let title: String
    @Binding public var askFeedback: Bool
    var storeReview = StoreReview()
    
    public init(title: String, askFeedback: Binding<Bool>) {
        self.title = title
        self._askFeedback = askFeedback
    }
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.01)
            
            VStack(spacing: 20) {
                Text(title)
                    .bold()
                    .font(.title)
                HStack {
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("star")
                        .resizable()
                        .frame(width: 22.5, height: 22.5)
                        .offset(y: -2.5)
                    Image("star")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .offset(y: -5)
                    Image("star")
                        .resizable()
                        .frame(width: 22.5, height: 22.5)
                        .offset(y: -2.5)
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text("Help us with a review")
                    .bold()
                    .font(.body)
                Spacer()
                HStack {
                    Button(action: {
                        askFeedback.toggle()
                    }) {
                        Text("No")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .menuViewStyle()
                            .padding(1)
                            .background(Color.gray.cornerRadius(30))
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(ScaleButton())
                    
                    Button(action: {
                        storeReview.requestReview()
                        askFeedback.toggle()
                    }) {
                        Text("Yes")
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .padding(1)
                            .background(Color.green.cornerRadius(30))
                            .springEffect(animationTrigger: .constant(true))
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(ScaleButton())
                }
                .font(.title2)
            }
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 275, height: 275)
            .menuViewStyle()
        }
        .transition(.opacity)
    }
}

@available(iOS 15.0, *)
struct AskForReview_Previews: PreviewProvider {
    static var previews: some View {
        AskForReview(title: "Loving _ game?", askFeedback: .constant(false))
            .background(Color.menuTitle)
            .previewLayout(PreviewLayout.sizeThatFits)
            .colorScheme(.dark)
    }
}
