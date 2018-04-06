//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Smith on 01/04/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import Foundation

class Concentration {

    var cards = [Card]()
    
    var faceUpCardIndex: Int?
    
    var flipCount = 0
    
    var score = 0;
    
    var fiveSecondAttemptTime: Date
    
    func reset() {
        flipCount = 0
        score = 0
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].witnessed = false
        }
    }
    
    
    func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            flipCount += 1
            
            //if a card is face up and not the one you picked
            if let matchIndex = faceUpCardIndex, matchIndex != index {
                
                // If cards match
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    
                    //EXTRA CREDIT - TIME BONUS
                    //If we find a match in less than 5 seconds give a bonus point
                    if fiveSecondAttemptTime > Date.init() {
                        score += 1
                    }
                    
                } else {
                    // They dont match, check if the either have been witnessed previously
                    if cards[index].witnessed {
                        score -= 1
                    }
                    if cards[matchIndex].witnessed {
                        score -= 1
                    }
                }
                faceUpCardIndex = nil
                
                // After attempting a match, remember we witnessed the cards
                cards[index].witnessed = true
                cards[matchIndex].witnessed = true
            } else {
                
                // either no cards or two cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                faceUpCardIndex = index
                // Start the 5 second timer
                fiveSecondAttemptTime = Date.init().addingTimeInterval(5)
            }

            cards[index].isFaceUp = true
        }
    }
    
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            // create a card and add two copies to the cards array
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        var lastCardIndex = cards.count - 1;
        
        while lastCardIndex > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(lastCardIndex)))
            cards.swapAt(randomIndex, lastCardIndex)
            lastCardIndex -= 1
        }
        
        fiveSecondAttemptTime = Date.init()
    }
    
}
