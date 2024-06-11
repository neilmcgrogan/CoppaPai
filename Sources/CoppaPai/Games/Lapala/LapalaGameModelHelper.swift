//
//  LapalaGameModelHelper.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 6/10/24.
//

import SwiftUI

@available(iOS 15.0, *)
extension LapalaGameModel {
    func countUniqueLetters(in word1: String, and word2: String) -> Int {
        let combined = word1 + word2
        let uniqueLetters = Set(combined)
        return uniqueLetters.count
    }

    func findPairWithTwelveUniqueLetters(from words: [String]) -> (String, String)? {
        let startIndex = Int.random(in: 0..<words.count)
        
        for i in 0..<words.count {
            let index1 = (startIndex + i) % words.count
            let word1 = words[index1]
            
            for j in 0..<words.count {
                if index1 == j { continue }
                let index2 = (startIndex + j) % words.count
                let word2 = words[index2]
                
                if countUniqueLetters(in: word1, and: word2) == 12 && !hasDuplicateConsecutiveLetters(in: word1) && !hasDuplicateConsecutiveLetters(in: word2) && firstMatchesLast(word1: word1, word2: word2) {
                    return (word1, word2)
                }
            }
        }
        
        return nil
    }
    
    func firstMatchesLast(word1: String, word2: String) -> Bool {
        return word1.last == word2.first || word2.last == word1.first
    }
    
    func hasDuplicateConsecutiveLetters(in word: String) -> Bool {
        var previousCharacter: Character?
        for character in word {
            if character == previousCharacter {
                return true
            }
            previousCharacter = character
        }
        return false
    }

    func findAdjacentCharacters(in string: String) -> [Character: Set<Character>] {
        var adjacencyList = [Character: Set<Character>]()
        
        let charactersArray = Array(string)
        
        for (index, char) in charactersArray.enumerated() {
            if index > 0 {
                let previousChar = charactersArray[index - 1]
                adjacencyList[char, default: Set()].insert(previousChar)
                adjacencyList[previousChar, default: Set()].insert(char)
            }
        }
        return adjacencyList
    }

    func isValidPlacement(_ sides: [[Character]], adjacencyList: [Character: Set<Character>], sideIndex: Int, char: Character) -> Bool {
        for c in sides[sideIndex] {
            if adjacencyList[char]?.contains(c) == true {
                return false
            }
        }
        return true
    }

    func distributeCharacters(_ characters: [Character], adjacencyList: [Character: Set<Character>], sides: inout [[Character]], index: Int) -> Bool {
        if index == characters.count {
            return sides.allSatisfy { $0.count == 3 }
        }
        
        let char = characters[index]
        
        for i in 0..<sides.count {
            if sides[i].count < 3 && isValidPlacement(sides, adjacencyList: adjacencyList, sideIndex: i, char: char) {
                sides[i].append(char)
                if distributeCharacters(characters, adjacencyList: adjacencyList, sides: &sides, index: index + 1) {
                    return true
                }
                sides[i].removeLast()
            }
        }
        
        return false
    }

    func functionalFlow(strs: [String]) -> String {
        return strs.joined()
    }

    func strippedDownList(strs: [String]) -> [Character] {
        return Array(strs.joined())
    }
    
    
    /*
    func countUniqueLetters(in word1: String, and word2: String) -> Int {
        let combined = word1 + word2
        let uniqueLetters = Set(combined)
        return uniqueLetters.count
    }

    func findPairWithTwelveUniqueLetters(from words: [String]) -> (String, String)? {
        let startIndex = Int.random(in: 0..<words.count)
        
        for i in 0..<words.count {
            let index1 = (startIndex + i) % words.count
            let word1 = words[index1]
            
            for j in 0..<words.count {
                if i == j { continue }
                let index2 = (startIndex + j) % words.count
                let word2 = words[index2]
                
                if countUniqueLetters(in: word1, and: word2) == 12 {
                    return (word1, word2)
                }
            }
        }
        
        return nil
    }
    
    
    func isTwelveChar(strs: [String]) -> Bool {
        // Combine the words into one string
        let combinedString = strs.joined()

        // Create a set of unique characters
        let uniqueCharacters = Set(combinedString)
        
        // Check if there are exactly 12 unique characters
        return uniqueCharacters.count == 12
    }
    
    func strippedDownList(strs: [String]) -> [Character] {
        // Combine the words into one string
        let combinedString = strs.joined()

        // Create a set of unique characters
        let uniqueCharacters = Set(combinedString)
        
        return Array(uniqueCharacters)
    }
    
    func functionalFlow(strs: [String]) -> String {
        // Combine the words into one string
        let combinedString = strs.joined()
        return combinedString
    }
    
    // Find adjacent characters in the input string
    func findAdjacentCharacters(in string: String) -> [Character: Set<Character>] {
        var adjacencyList = [Character: Set<Character>]()
        
        let charactersArray = Array(string)
        
        for (index, char) in charactersArray.enumerated() {
            if index > 0 {
                let previousChar = charactersArray[index - 1]
                adjacencyList[char, default: Set()].insert(previousChar)
                adjacencyList[previousChar, default: Set()].insert(char)
            }
        }
        return adjacencyList
    }

    // Function to check if the placement is valid
    func isValidPlacement(_ sides: [[Character]], adjacencyList: [Character: Set<Character>], sideIndex: Int, char: Character) -> Bool {
        for c in sides[sideIndex] {
            if adjacencyList[char]?.contains(c) == true {
                return false
            }
        }
        return true
    }

    // Function to distribute characters into four sides
    func distributeCharacters(_ characters: [Character], adjacencyList: [Character: Set<Character>], sides: inout [[Character]], index: Int) -> Bool {
        if index == characters.count {
            return sides.allSatisfy { $0.count == 3 }
        }
        
        let char = characters[index]
        
        for i in 0..<sides.count {
            if sides[i].count < 3 && isValidPlacement(sides, adjacencyList: adjacencyList, sideIndex: i, char: char) {
                sides[i].append(char)
                if distributeCharacters(characters, adjacencyList: adjacencyList, sides: &sides, index: index + 1) {
                    return true
                }
                sides[i].removeLast()
            }
        }
        
        return false
    }*/
}
