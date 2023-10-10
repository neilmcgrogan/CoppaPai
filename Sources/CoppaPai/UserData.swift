//
//  UserData.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/9/23.
//

import SwiftUI

@available(iOS 13.0, *)
public class UserData: ObservableObject {
    
    @Published var gamesPlayed: Int {
        didSet { defaults.set(gamesPlayed, forKey: "games_played") }
    }
    
    init() {
        self.gamesPlayed = defaults.object(forKey: "games_played") as? Int ?? 0
    }
}
