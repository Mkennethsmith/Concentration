//
//  Card.swift
//  Concentration
//
//  Created by Michael Smith on 01/04/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp  = false
    var isMatched = false
    var flipped   = false
    var identifier: Int
    
    static var identifierFactory = 0;
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
