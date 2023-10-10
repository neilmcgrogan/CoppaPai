//
//  StoreReview.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/9/23.
//

import StoreKit
import SwiftUI

struct StoreReview {
    func requestReview() {
        if #available(iOS 14.0, *) {
            if let scene = UIApplication.shared.currentScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
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

@available(iOS 14.0, *)
public struct AskForReview: View {
    let title: String
    @Binding var askFeedback: Bool
    let winCriteria: (Int, Int, Int)
    var storeReview = StoreReview()
    
    public var body: some View {
        ZStack {
            Color.gray.opacity(0.01)
            
            VStack {
                Text("\(title)")
                    .bold()
                    .font(.title)
                HStack {
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image("star")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text("Leave us a review?")
                    .bold()
                    .font(.title3)
                Spacer()
                HStack {
                    Spacer()
                    Button("No") {
                        askFeedback.toggle()
                    }.buttonStyle(ScaleButton())
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Color.red)
                    .cornerRadius(20)
                    .padding(1.5)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(1.5)
                    Spacer()
                    Button("Yes") {
                        storeReview.requestReview()
                        askFeedback.toggle()
                        storeReview.requestReview()
                    }.buttonStyle(ScaleButton())
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background(Color.green)
                    .cornerRadius(20)
                    .padding(1.5)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(1.5)
                    Spacer()
                }
                .font(.title2)
            }
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 230, height: 225)
            .background(
                Color.menuTitle
                    .frame(width: 230, height: 225)
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 2)
            )
        }
        .transition(.opacity)
    }
}

@available(iOS 14.0, *)
struct AskForReview_Previews: PreviewProvider {
    static var previews: some View {
        AskForReview(title: "Loving _ game?", askFeedback: .constant(false), winCriteria: (2, 10, 20))
            .background(Color.menuTitle)
            .previewLayout(PreviewLayout.sizeThatFits)
            .colorScheme(.dark)
    }
}
