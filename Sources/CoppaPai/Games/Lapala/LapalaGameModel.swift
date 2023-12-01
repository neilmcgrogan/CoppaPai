//
//  LapalaGameModel.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/25/23.
//

import SwiftUI



@available(iOS 15.0, *)
public class LapalaGameModel: ObservableObject {
    
    @Published var scoreAnimation = false {
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation() {
                    self.scoreAnimation = false
                }
            }
        }
    }
    @Published var char: [String] = []
    @Published var guess: String = ""
    @Published var incorrectGuess: Bool = false {
        didSet{
            if incorrectGuess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.incorrectGuess = false
                }
            }
        }
    }
    @Published var guessed: String = ""
    @Published public var words: [String] = [] {
        didSet{
            var allLetters: [Character] = []
            for word in words {
                for letter in word {
                    if !allLetters.contains(letter) {
                        allLetters.append(letter)
                        withAnimation() { progress =  Double(allLetters.count) / 12.0 }
                    }
                }
            }
            if allLetters.count == 12 {
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(words.last?.count ?? 0) * delayConst)) {
                    self.winStreak += 1
                    self.status = .finished
                }
            }
        }
    }
    @Published public var status: GameStatus = .notPlaying
    @Published var progress: Double = 0
    @Published var winStreak: Int {
        didSet {
            defaults.set(winStreak, forKey: "winStreak")
        }
    }
    @Published public var gamesPlayed: Int {
        didSet { defaults.set(gamesPlayed, forKey: "games_played") }
    }
    @Published public var showInterstitialAd: Bool = false {
        didSet{
            if showInterstitialAd {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showInterstitialAd = false
                }
            }
        }
    }
    
    public init() {
        
        print("working")
        self.winStreak = defaults.object(forKey: "winStreak") as? Int ?? 0
        self.gamesPlayed = defaults.object(forKey: "games_played") as? Int ?? 0
        
        self.getLetters()
    }
    
    func gameRestart() {
        self.getLetters()
        self.words.removeAll()
        self.guess = ""
        self.progress = 0.0
        withAnimation() {
            self.status = .playing
        }
        self.showInterstitialAd = true
        self.gamesPlayed += 1
    }
    
    func restart() {
        words.removeAll()
        guess = ""
        withAnimation() { progress =  0.0 }
    }
    
    func deletable() -> Bool {
        if words.isEmpty && guess.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func delete() {
        if guess.count == 1 {
            guess.removeLast()
            guess = words.last ?? ""
            if words.count > 0 {
                words.removeLast()
            }
        } else {
            if !guess.isEmpty {
                guess.removeLast()
            }
        }
    }
    
    func enter() {
        if guess.count > 2 {
            if let path = Bundle.main.path(forResource: "words_all", ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .utf8)
                    if data.contains("\n\(guess.lowercased())\n") {
                        print("working3")
                        guessed = guess
                        let guessedCount = guess.count
                        guess = ""
                        self.scoreAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + (delayConst * Double(guessedCount))) {
                            self.words.append(self.guessed)
                            self.guess = String(self.words.last?.suffix(1) ?? "")
                            self.guessed = String(self.words.last?.suffix(1) ?? "")
                        }
                    } else {
                        print("word not in bank")
                        withAnimation() {
                            incorrectGuess = true
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func returnPath(lhs: String, rhs: String) -> (CGPoint, CGPoint) {
        let leftIndex = char.firstIndex(of: lhs)
        let rightIndex = char.firstIndex(of: String(rhs.suffix(1)))
        
        if let l = leftIndex, let r = rightIndex {
            return (CGPoint(x: locations[l].x, y: locations[l].y), CGPoint(x: locations[r].x, y: locations[r].y))
        } else {
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 0))
        }
    }
    
    func placeNew() -> [Int] {
        var points: [Int] = []
        
        for letter in guessed {
            if let index = char.firstIndex(of: String(letter)) {
                points.append(index)
            }
        }
        
        return points
    }
    
    /// Gets letters to be laoded onto the board
    private func getLetters() {
        self.char.removeAll()
        
        var vowel = vowels.shuffled()
        var consonant = consonants.shuffled()
        
        let vowelAmount = Int.random(in: 4...5)
        
        for _ in 1...vowelAmount {
            char.append(vowel.last ?? "_")
            vowel.removeLast()
        }
        for _ in 1...(12-vowelAmount) {
            char.append(consonant.last ?? "_")
            consonant.removeLast()
        }
        char.shuffle()
        if char.contains("Q") {
            print("run a check now!")
            if !char.contains("U") {
                print("Fix now")
                char[1] = "U"
            }
        }
    }
    
    func containsLetter(letter: String) -> Bool {
        if guess.contains(letter) {
            return true
        } else {
            for word in words {
                if word.contains(letter) {
                    return true
                }
            }
            return false
        }
    }
    
    /// Take in candidate next guess
    /// Find where it is on the array, determine if it is
    func validateMove(candidate: Int) {
        let last = guess.last ?? String.Element(" ")
        if char[candidate] == String(last) {
            guess.removeLast()
        } else {
            switch candidate {
            case 0...2:
                if char[0] != String(last) && char[1] != String(last) && char[2] != String(last) {
                    guess += char[candidate]
                }
            case 3...5:
                if char[3] != String(last) && char[4] != String(last) && char[5] != String(last) {
                    guess += char[candidate]
                }
            case 6...8:
                if char[6] != String(last) && char[7] != String(last) && char[8] != String(last) {
                    guess += char[candidate]
                }
            default:
                if char[9] != String(last) && char[10] != String(last) && char[11] != String(last) {
                    guess += char[candidate]
                }
            }
        }
    }
    
    let characters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let vowels = ["A", "E", "I", "O", "U", "Y"]
    let consonants = ["B", "C", "D", "F", "G", "H", "K", "L", "M", "N", "P", "R", "S", "T", "V", "W", "Z"]//["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
 }
