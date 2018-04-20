//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Smith on 31/03/2018.
//  Copyright © 2018 Michael Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var cardColor    = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private var cardEmoji    = [Card:String]()
    private var emojiChoices = [String]()
    private var currentThemeIndex = 0
    
    private let themes = [
        Theme(name: "halloween", emoji:["👻","🎃","🧛🏼‍♂️","🦇","🍬","🍭","🍫","😈","🧟‍♂️","🍎"], colours: [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]),
        Theme(name: "faces", emoji:["😀","😍","😴","😱","🤣","😂","😉","🙄","😬","🤨"], colours: [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)]),
        Theme(name: "animals", emoji:["🐶","🐱","🐼","🦊","🦁","🐯","🐨","🐮","🐷","🐵"], colours: [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]),
        Theme(name: "summer", emoji:["🏄🏼‍♂️","🏊🏼‍♀️","☀️","🌈","🌼","🏖","⛱","🏝","🎣","🍦"], colours: [#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)]),
        Theme(name:"winter", emoji:["⛄️","🧣","🌨","❄️","🎿","🏂","⛷","🏒","⛸","🛷"], colours: [#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)]),
        Theme(name:"jobs", emoji:["👩🏼‍💻","👨🏼‍🏫","👩🏼‍🔬","👨🏼‍🍳","👩🏼‍🌾","👩🏼‍🚀","👩🏼‍✈️","👨🏼‍⚖️","👩🏼‍🔧","👨🏼‍🏭"], colours: [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1),#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]),
    ]
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    // EXTRA CREDIT - Setting Theme
    override func viewDidLoad() {
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Card chosen was not in cardButtons array")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        game.reset()
        cardEmoji.removeAll()
        setTheme()
        updateViewFromModel()
    }
    
    private func updateViewFromModel () {
        
        //Update the Flip count
        flipCountLabel.text = "Flips: \(game.flipCount)"
        flipCountLabel.textColor = cardColor
        
        //Update the Score
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
    
    
    private func getEmoji(for card: Card) -> String {
        //Add the emoji choice to the emoji dictionary
        if cardEmoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = getRandomIndex(for: emojiChoices.count)
            cardEmoji[card] = emojiChoices.remove(at: randomIndex)
        }
        return cardEmoji[card] ?? "?"
    }
    
    
    // EXTRA CREDIT - Setting theme
    private func setTheme() {
        
        // Get a random theme from the themes dictionary
        var newThemeIndex = getRandomIndex(for: themes.count)
        
        // Ensure we dont get the same theme twice in a row
        while newThemeIndex == currentThemeIndex {
            newThemeIndex = getRandomIndex(for: themes.count)
        }
        
        currentThemeIndex = newThemeIndex
        emojiChoices = themes[currentThemeIndex].emoji
        cardColor = themes[currentThemeIndex].colours[0]
        themeLabel.text = themes[currentThemeIndex].name
        themeLabel.textColor = cardColor
        view.backgroundColor = themes[currentThemeIndex].colours[1]
    }
    
    // Helper to get random index from desired array count.
    private func getRandomIndex(for arrayCount: Int) -> Int {
        return Int(arc4random_uniform(UInt32(arrayCount)))
    }
    
}


