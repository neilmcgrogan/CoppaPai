//
//  AskForReview.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 12/28/23.
//

import SwiftUI

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
            .padding()
            .frame(width: 285, height: 285)
            .menuViewStyle()
        }
        .transition(.opacity)
    }
}

@available(iOS 15.0, *)
#Preview {
    AskForReview(title: "Loving _ game?", askFeedback: .constant(false))
        .background(Color.menuTitle)
        .previewLayout(PreviewLayout.sizeThatFits)
        .colorScheme(.light)
}
