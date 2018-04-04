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
    
    func reset() {
        flipCount = 0
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
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
                }
                cards[index].isFaceUp = true
                faceUpCardIndex = nil
            } else {
                // either no cards or two cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                faceUpCardIndex = index
            }
        }
    }
    
    
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            // create a card and add two copies to the cards array
            let card = Card()
            cards += [card, card]
        }
        
        var lastCardIndex = cards.count - 1;
        
        while lastCardIndex > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(lastCardIndex)))
            cards.swapAt(randomIndex, lastCardIndex)
            lastCardIndex -= 1
        }
    
    }
    
}
