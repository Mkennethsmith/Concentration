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
        #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1): ["😀","😍","😴","😱","🤣","😂","😉","🙄","😬", "🤨"],
        #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1): ["👻","🎃","🧛🏼‍♂️","🦇","🍬","🍭","🍫","😈","🧟‍♂️", "🍎"],
        #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1): ["🐶","🐱","🐼","🦊","🦁","🐯","🐨","🐮","🐷", "🐵"],
        #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1): ["🏄🏼‍♂️","🏊🏼‍♀️","☀️","🌈","🌼","🏖","⛱","🏝","🎣", "🍦"],
        #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1): ["⛄️","☃️","🌨","❄️","🎿","🏂","⛷","🏒","⛸", "🛷"],
        #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1): ["👩🏼‍💻","👨🏼‍🏫","👩🏼‍🔬","👨🏼‍🍳","👩🏼‍🌾","👩🏼‍🚀","👩🏼‍✈️","👨🏼‍⚖️","👩🏼‍🔧", "👨🏼‍🏭"],
    ]
    
    
    lazy var theme = [UIColor: [String]]( )
    
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
        emoji.removeAll()
        theme = setTheme()
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : theme.first?.key
            }
        }
    }
    
    func getEmoji(for card: Card) -> String {
    
        var themeEmoji = theme.first!.value
        //Add the emoji choice to the emoji dictionary
        if emoji[card.identifier] == nil, theme.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themeEmoji.count)))
            emoji[card.identifier] = themeEmoji.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func setTheme() -> [UIColor: [String]] {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        let themes = Array(emojiChoices.keys)
        let themeColor = themes[randomIndex]
        let emoji = emojiChoices[themeColor] ?? ["?"]
        return [themeColor: emoji]
    }

    
}


