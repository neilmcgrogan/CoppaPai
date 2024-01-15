//
//  HelpView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 12/28/23.
//

import SwiftUI

@available(iOS 16.0, *)
public struct HelpView: View {
    @Binding var showHelp: Bool
    let texts: [(String, String)]
    
    public init(showHelp: Binding<Bool>, texts: [(String, String)]) {
        self._showHelp = showHelp
        self.texts = texts
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation() {
                    self.showHelp = false
                }
            }) {
                HStack {
                    Text("How to Play")
                        .bold()
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
                .font(.title)
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(texts.indices, id: \.self) { index in
                        let text = texts[index]
                        Group {
                            Text(text.0).bold()
                            Text(LocalizedStringKey(text.1))
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .multilineTextAlignment(.leading)
            }
        }
        .fontWeight(.light)
        .padding()
        .gameMenuViewStyle()
        .padding()
    }
}

@available(iOS 16.0, *)
#Preview {
    HelpView(showHelp: .constant(false), texts: [("Guess two words in 6 tries.", "- Each guess must be a valid 5-letter word.\nThe color of the tiles will change to show how close your guess was to the word."), ("Examples.", "- Green is in the word and in the correct spot.\n- Yellow is in the word but in the wrong spot.\n- Gray is not in the word in any spot.")])
}
