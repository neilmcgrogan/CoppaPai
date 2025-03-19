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
    
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        VStack {
            Image(colorScheme == .light ? "Black_Wreath" : "Wreath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .overlay(
                    Text(title)
                        .font(.title)
                        .bold()
                )
            
            Spacer()
            
            HStack {
                Image("star")
                    .resizable()
                    .frame(width: 25, height: 25)
                Image("star")
                    .resizable()
                    .frame(width: 27.5, height: 27.5)
                    .offset(y: -5.0)
                Image("star")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .offset(y: -7.5)
                Image("star")
                    .resizable()
                    .frame(width: 27.5, height: 27.5)
                    .offset(y: -5.0)
                Image("star")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            
            Text("Help us with a review")
                .font(.headline)
            
            Spacer()
            
            HStack {
                Button(action: {
                    askFeedback.toggle()
                }) {
                    Text("No")
                        .padding(.vertical, 15)
                        .padding(.horizontal, 45)
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
                        .padding(.vertical, 15)
                        .padding(.horizontal, 45)
                        .padding(1)
                        .background(Color.green.cornerRadius(30))
                        .springEffect(animationTrigger: true)
                        .frame(maxWidth: .infinity)
                }.buttonStyle(ScaleButton())
            }
            .font(.title2)
            .foregroundStyle(Color.black)
        }
        .padding(15)
    }
}

@available(iOS 15.0, *)
#Preview {
    AskForReview(title: "Loving _ game?", askFeedback: .constant(false))
        .background(Color.menuTitle)
        .previewLayout(PreviewLayout.sizeThatFits)
        .colorScheme(.light)
}
