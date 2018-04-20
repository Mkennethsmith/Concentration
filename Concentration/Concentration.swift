//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Smith on 01/04/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import Foundation

class Concentration {

    private(set) var cards = [Card]()
    
    private var faceUpCardIndex: Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private var witnessedCards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var score = 0;
    
    private var twoSecondAttemptTime: Date
    
    private(set) var scoredBonus = false
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,
            "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards) : You need at least 1 pair of cards")
        
        //Create the specified numbered pairs of cards
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
        
        twoSecondAttemptTime = Date.init()
    }
    
    //Reset the Game
    func reset() {
        flipCount = 0
        score = 0
        scoredBonus = false
        for index in 0..<cards.count {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        witnessedCards.removeAll()
    }
    
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Consentration.chooseCard(at: \(index): chosen index no in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            
            //if a card is face up and not the one you picked
            if let matchIndex = faceUpCardIndex, matchIndex != index {
                
                // If cards match
                if cards[index] == cards[matchIndex] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    
                    //EXTRA CREDIT - TIME BONUS
                    //If we find a match in less than 5 seconds give a bonus point
                    if twoSecondAttemptTime > Date.init() {
                        score += 1
                        scoredBonus = true
                    } else {
                        scoredBonus = false
                    }
                    
                } else {
                    // They dont match, check if the either have been witnessed previously
                    if(witnessedCards.contains(cards[index])) {
                        score -= 1
                    }
                    
                    if witnessedCards.contains(cards[matchIndex]) {
                        score -= 1
                    }
                    
                }
                
                cards[index].isFaceUp = true
                witnessedCards += [cards[index], cards[matchIndex]]
                //TODO: remove the witnessed property, and replace with a wittnessed cards array.
            } else {
                faceUpCardIndex = index
                // Start the 5 second timer
                scoredBonus = false
                twoSecondAttemptTime = Date.init().addingTimeInterval(2)
            }
        }
    }
}

//Return the element if there is only one in a collection.
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
