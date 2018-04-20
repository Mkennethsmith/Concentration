//
//  Card.swift
//  Concentration
//
//  Created by Michael Smith on 01/04/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var isFaceUp  = false
    var isMatched = false
    private var identifier: Int
    
    var hashValue: Int {
       return self.identifier;
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
