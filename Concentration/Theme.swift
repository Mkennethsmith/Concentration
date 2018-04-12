//
//  Theme.swift
//  Concentration
//
//  Created by Michael Smith on 07/04/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import UIKit
import Foundation

struct Theme {
    
    var emoji: [String]
    var colours: [UIColor]
    var name: String
    
    init(name: String, emoji:[String], colours: [UIColor]) {
        self.emoji = emoji
        self.colours = colours
        self.name = emoji[0]+name.capitalized+emoji[1]
    }
    
}
