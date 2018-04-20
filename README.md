# Stanford_Concentration
Stanford University Course Concentration App

This is my attempt at the 1st Assignment for CS193P IOS APPLICATION DEVELOPMENT course at Stanford University.

https://itunes.apple.com/us/course/developing-ios-11-apps-with-swift/id1309275316

I've edited the outline to cater for someone following the course in their own time. 

## Objective
The goal of this assignment is to recreate the demonstration given in lectures 1 and 2 and then make some small enhancements. 
It is important that you understand what you are doing with each step of recreating the demo from lecture so that you are prepared to do the enhancements.
Another goal is to get experience creating a project in Xcode and typing code in from scratch. Do not copy/paste any of the code from anywhere. Type it in 
and watch what Xcode does as you do so. This assignment should be completed before attempting week 4 lectures 
(i.e. before lecture 4).


## Materials
• You will need to install the (free) program Xcode 9 using the App Store on your Mac (previous versions of Xcode will NOT work). It is highly recommended that you do this immediately so that if you have any problems getting Xcode to work, you have time to get help from Piazza and/or the TAs in their office hours.

• A link to the video of the lectures can be found in the same place you found this document.

## Required Tasks
1. Get the Concentration game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.
2. Add more cards to the game.
3. Add a “New Game” button to your UI which ends the current game in progress and begins a brand new game.
4. Currently the cards in the Model are not randomized (that’s why matching cards end up always in the same place in our UI). Shuffle the cards in Concentration’s init() method.
5. Give your game the concept of a “theme”. A theme determines the set of emoji from which cards are chosen. All emoji in a given theme are related by that theme. See the Hints for example themes. Your game should have at least 6 different themes and should choose a random theme each time a new game starts.
6. Your architecture must make it possible to add a new theme in a single line of code.
7. Add a game score label to your UI. Score the game by giving 2 points for every match and penalizing 1 point for every previously seen card that is involved in a mismatch.
8. Tracking the flip count almost certainly does not belong in your Controller in a proper MVC architecture. Fix that.
9. All new UI you add should be nicely laid out and look good in portrait mode on an iPhone X.

## Things to Learn
Here is a partial list of concepts this assignment is intended to let you gain practice with or otherwise demonstrate your knowledge of.
1. Xcode 9
2. Swift
3. MVC
4. UIViewController subclass
5. UILabel and UIButton
6. Target/Action (@IBAction)
7.Outlets (@IBOutlet) and Outlet Collections 
8. functions and properties (instance variables) 
9. let versus var
10. Valuetype(struct,enum)versusreferencetype(class)
11. Strong typing and type inference
12. didSet
13. forin(and..<CountableRangesyntax)
14. Array<Element> and Dictionary<Key, Value>
15. [Element]and[Key:Value]syntax
16. initialization of struct and class
17. viewDidLoad
18. Optionals (including implicitly-unwrapped Optionals)
19. ?? optional defaulting operator
20. // TODO
21. arc4random()
22. Type conversion (e.g. from UInt to Int)
23. Stack View and (simple) autolayout

## Evaluation
In all of the assignments, writing quality code that builds without warnings or errors, and then testing the resulting application and iterating until it functions properly is the goal.
Here are the most common reasons assignments are marked down:
• Project does not build.
• One or more items in the Required Tasks section was not satisfied.
• Afundamentalconceptwasnotunderstood.
• Project does not build without warnings.
• Code is visually sloppy and hard to read (e.g. indentation is not consistent, etc.).
• Your solutionis difficult(or impossible) for someone reading the code to understand due to lack of comments, poor variable/method names, poor solution structure, long methods, etc.

Often students ask “how much commenting of my code do I need to do?” The answer is that your code must be easily and completely uderstandable by anyone reading it. 
You can assume that the reader knows the iOS API and knows how the Concentration game code from lectures 1 and 2 works, but should not assume that they already know your (or any) solution to the assignment.
