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
    
    var emoji        = [Int:String]()
    var cardColor    = UIColor()
    var emojiChoices = [String]()
    
    let themes = [
        "halloween": ["emoji": ["👻","🎃","🧛🏼‍♂️","🦇","🍬","🍭","🍫","😈","🧟‍♂️","🍎"], "colors": [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)] ],
        "faces": ["emoji": ["😀","😍","😴","😱","🤣","😂","😉","🙄","😬","🤨"], "colors": [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)] ],
        "animals": ["emoji": ["🐶","🐱","🐼","🦊","🦁","🐯","🐨","🐮","🐷","🐵"], "colors": [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)] ],
        "summer": ["emoji" : ["🏄🏼‍♂️","🏊🏼‍♀️","☀️","🌈","🌼","🏖","⛱","🏝","🎣","🍦"], "colors": [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)] ],
        "winter": ["emoji" : ["⛄️","☃️","🌨","❄️","🎿","🏂","⛷","🏒","⛸","🛷"], "colors": [#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)]],
        "jobs": ["emoji" : ["👩🏼‍💻","👨🏼‍🏫","👩🏼‍🔬","👨🏼‍🍳","👩🏼‍🌾","👩🏼‍🚀","👩🏼‍✈️","👨🏼‍⚖️","👩🏼‍🔧","👨🏼‍🏭"], "colors": [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)] ],
    ]
    
    override func viewDidLoad() {
        setTheme()
        updateViewFromModel()
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!

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
        setTheme()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel () {
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        flipCountLabel.textColor = cardColor
        scoreLabel.text = "Score: \(game.score)"
        scoreLabel.textColor = cardColor

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
            }
        }
    }
    
    func getEmoji(for card: Card) -> String {
        //Add the emoji choice to the emoji dictionary
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func setTheme() {
        let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
        let themeKeys = Array(themes.keys)
        let themeName = themeKeys[randomIndex]
        let theme = themes[themeName] ?? nil
        
        if theme != nil {
            emojiChoices = theme!["emoji"] as! [String]
            let colors = theme!["colors"] ?? [#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
            
            cardColor = (colors[0] as! UIColor)
            view.backgroundColor = (colors[1] as! UIColor)
        }
        
    }
    

    
}


