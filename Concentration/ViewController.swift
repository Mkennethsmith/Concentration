//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Smith on 31/03/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var emoji = [Int:String]()
    
    var emojiChoices = [
        "faces" : ["😀","😍","😴","😱","🤣","😂","😉","🙄","😬", "🤨"],
        "halloween" :["👻","🎃","🧛🏼‍♂️","🦇","🍬","🍭","🍫","😈","🧟‍♂️", "🍎"],
        "animals" : ["🐶","🐱","🐼","🦊","🦁","🐯","🐨","🐮","🐷", "🐵"],
        "summer" : ["🏄🏼‍♂️","🏊🏼‍♀️","☀️","🌈","🌼","🏖","⛱","🏝","🎣", "🍦"],
        "winter" : ["⛄️","☃️","🌨","❄️","🎿","🏂","⛷","🏒","⛸", "🛷"],
        "jobs" : ["👩🏼‍💻","👨🏼‍🏫","👩🏼‍🔬","👨🏼‍🍳","👩🏼‍🌾","👩🏼‍🚀","👩🏼‍✈️","👨🏼‍⚖️","👩🏼‍🔧", "👨🏼‍🏭"],
    ]
    
    lazy var themeEmoji = [String]( setThemeEmoji() )
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card chosen was not in cardButtons array")
        }
    }
    
    @IBAction func touchNewGame(_ sender: Any) {
        game.reset()
        themeEmoji.removeAll()
        emoji.removeAll()
        themeEmoji = setThemeEmoji()
        updateViewFromModel()
    }
    
    func updateViewFromModel () {
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    
    func getEmoji(for card: Card) -> String {
    
        //Add the emoji choice to the emoji dictionary
        if emoji[card.identifier] == nil, themeEmoji.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themeEmoji.count)))
            emoji[card.identifier] = themeEmoji.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func setThemeEmoji() -> [String] {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        let themes = Array(emojiChoices.keys)
        let theme = themes[randomIndex]
        themeLabel.text = "\(theme)"
        return emojiChoices[theme] ?? ["?"]
    }

    
}


