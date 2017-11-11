//
//  ViewController.swift
//  RMiller_Final_Project
//
//  Created by Rob on 2/18/17.
//  Copyright © 2017 Rob. All rights reserved.
//
import UIKit


var playerTwoStartingDeck = startingDeck
var playerTwoBuyDeck = deck
var playerTwoWilds = wildFiveCent
var playerDeck = startingHand
var discardPile = discard

struct Money{
    static var money : Int = 0
    static var moneyP2: Int = 0
    static var index0Score: Int = 0
    static var index1Score: Int = 0
    static var index2Score: Int = 0
    static var index3Score: Int = 0
    static var index4Score: Int = 0
    static var index5Score: Int = 0
    static var scoreP2: Int = 5
    static var score: Int = 0
}

func scoring(){
    Money.score = 0
    for i in playerDeck{
        Money.score += i.endGamePoint
    }
}

class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var playerTwoScore: UILabel!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet weak var newCardPile: UIImageView!
    @IBOutlet weak var commonDeck: UIImageView!
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var moneyAvailable: UILabel!
    @IBOutlet var cardHand0: UIImageView!
    @IBOutlet var cardHand1: UIImageView!
    @IBOutlet var cardHand2: UIImageView!
    @IBOutlet var cardHand3: UIImageView!
    @IBOutlet var cardHand4: UIImageView!
    @IBOutlet var point0: UIView!
    @IBOutlet var point1: UIView!
    @IBOutlet var point2: UIView!
    @IBOutlet var point3: UIView!
    @IBOutlet var point4: UIView!
    @IBOutlet var point5: UIView!
    
    var commonCards = common
    var hand = [Card]()
    var index0 : String = ""
    var index1 : String = ""
    var index2 : String = ""
    var index3 : String = ""
    var index4 : String = ""
    var index5 : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        scoring()
        commonSetup()
        setupHand()
        loadBackgroudImage()
        tapped()
        playerOneScore.text = String(Money.score)
        playerTwoScore.text = String(Money.scoreP2)
        continueButton.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerTwoTurn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupHand()
        playerOneScore.text = String(Money.score)
        playerTwoScore.text = String(Money.scoreP2)
        moneyAvailable.text = String(Money.money)
        continueButton.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
        self.endGame()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources @objc @objc that can be recreated.
    }
    
    func setupHand() {
        var fullDeck = playerDeck.shuffled()
        fullDeck += hand
        fullDeck.shuffle()
        hand = [Card]()

        for i in fullDeck[0...4]{
            hand.append(i)
        }
        cardHand0.image = UIImage(named: hand[0].type.rawValue)
        cardHand1.image = UIImage(named: hand[1].type.rawValue)
        cardHand2.image = UIImage(named: hand[2].type.rawValue)
        cardHand3.image = UIImage(named: hand[3].type.rawValue)
        cardHand4.image = UIImage(named: hand[4].type.rawValue)
        newCardPile.image = UIImage(named: "cardback")
        
        for i in 0...4{
            fullDeck.remove(at: i)
        }
    }
    
    func commonSetup(){
        commonCards.shuffle()
        commonDeck.image = UIImage(named: commonCards[0].type.rawValue)
    }
    
    func loadBackgroudImage(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    @IBAction func spellAWord(_ sender: UIButton) {
        buildWord()
        spellCheck()
    }
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view{
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func buildWord(){
        if (cardHand0.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = hand[0].name
            Money.index0Score = hand[0].points
        }
        if(cardHand0.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = hand[0].name
            Money.index1Score = hand[0].points
        }
        if(cardHand0.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = hand[0].name
            Money.index2Score = hand[0].points
        }
        if(cardHand0.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = hand[0].name
            Money.index3Score = hand[0].points
        }
        if(cardHand0.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = hand[0].name
            Money.index4Score = hand[0].points
        }
        if(cardHand0.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = hand[0].name
            Money.index5Score = hand[0].points
        }
        
        if(cardHand1.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = hand[1].name
            Money.index0Score = hand[1].points
        }
        if(cardHand1.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = hand[1].name
            Money.index1Score = hand[1].points
        }
        if(cardHand1.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = hand[1].name
            Money.index2Score = hand[1].points
        }
        if(cardHand1.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = hand[1].name
            Money.index3Score = hand[1].points
        }
        if(cardHand1.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = hand[1].name
            Money.index4Score = hand[1].points
        }
        if(cardHand1.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = hand[1].name
            Money.index5Score = hand[1].points
        }
        
        if(cardHand2.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = hand[2].name
            Money.index0Score = hand[2].points
        }
        if(cardHand2.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = hand[2].name
            Money.index1Score = hand[2].points
        }
        if(cardHand2.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = hand[2].name
            Money.index2Score = hand[2].points
        }
        if(cardHand2.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = hand[2].name
            Money.index3Score = hand[2].points
        }
        if(cardHand2.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = hand[2].name
            Money.index4Score = hand[2].points
        }
        if(cardHand2.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = hand[2].name
            Money.index5Score = hand[2].points
        }
        
        if(cardHand3.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = hand[3].name
            Money.index0Score = hand[3].points
        }
        if(cardHand3.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = hand[3].name
            Money.index1Score = hand[3].points
        }
        if(cardHand3.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = hand[3].name
            Money.index2Score = hand[3].points
        }
        if(cardHand3.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = hand[3].name
            Money.index3Score = hand[3].points
        }
        if(cardHand3.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = hand[3].name
            Money.index4Score = hand[3].points
        }
        if(cardHand3.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = hand[3].name
            Money.index5Score = hand[3].points
        }
        
        if(cardHand4.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = hand[4].name
            Money.index0Score = hand[4].points
        }
        if(cardHand4.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = hand[4].name
            Money.index1Score = hand[4].points
        }
        if(cardHand4.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = hand[4].name
            Money.index2Score = hand[4].points
        }
        if(cardHand4.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = hand[4].name
            Money.index3Score = hand[4].points
        }
        if(cardHand4.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = hand[4].name
            Money.index4Score = hand[4].points
        }
        if(cardHand4.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = hand[4].name
            Money.index5Score = hand[4].points
        }
        
        if(commonDeck.frame.intersects(point0.frame)){
            index0 = ""
            Money.index0Score = 0
            index0 = commonCards[0].name
            Money.index0Score = commonCards[0].points
        }
        if(commonDeck.frame.intersects(point1.frame)){
            index1 = ""
            Money.index1Score = 0
            index1 = commonCards[0].name
            Money.index1Score = commonCards[0].points
        }
        if(commonDeck.frame.intersects(point2.frame)){
            index2 = ""
            Money.index2Score = 0
            index2 = commonCards[0].name
            Money.index2Score = commonCards[0].points
        }
        if(commonDeck.frame.intersects(point3.frame)){
            index3 = ""
            Money.index3Score = 0
            index3 = commonCards[0].name
            Money.index3Score = commonCards[0].points
        }
        if(commonDeck.frame.intersects(point4.frame)){
            index4 = ""
            Money.index4Score = 0
            index4 = commonCards[0].name
            Money.index4Score = commonCards[0].points
        }
        if(commonDeck.frame.intersects(point5.frame)){
            index5 = ""
            Money.index5Score = 0
            index5 = commonCards[0].name
            Money.index5Score = commonCards[0].points
        }
    }
    
    func clearWord(){
        index0 = ""
        index1 = ""
        index2 = ""
        index3 = ""
        index4 = ""
        index5 = ""
        
        Money.index0Score = 0
        Money.index1Score = 0
        Money.index2Score = 0
        Money.index3Score = 0
        Money.index4Score = 0
        Money.index5Score = 0
    }
    
    func wordIsSpelledCorrect(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let wordRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return wordRange.location == NSNotFound
    }
    
    func spellCheck(){
        checkForWilds()
        
        var word = index0 + index1 + index2 + index3 + index4 + index5
        let money = Money.index2Score + Money.index4Score + Money.index1Score + Money.index0Score + Money.index3Score + Money.index5Score
        
        if word.characters.count <= 1{
            let alert = UIAlertController(title: "Error", message: "Invaild word", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if wordIsSpelledCorrect(word: word){
            moneyAvailable.text = String(money)
            Money.money = money
            let alert = UIAlertController(title: "Finished", message: "You have spelled \"\(word)\" and earned \(moneyAvailable.text!) points.  Click the continue button to buy new cards", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            index0 = ""
            index1 = ""
            index2 = ""
            index3 = ""
            index4 = ""
            index5 = ""
            continueButton.isUserInteractionEnabled = true
        }else{
            continueButton.isUserInteractionEnabled = false
            let alertController = UIAlertController(title: "Not a Word!", message: "The word \"\(word)\" is not valid, please try again" , preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            clearWord()
        }
    }
    
    func checkForWilds(){
        if index0.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if index1.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if index2.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if index3.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if index4.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
        if index5.contains("wild"){
            let alert = UIAlertController(title: "Warning", message: "Need to double tap on wild cards to choose letter", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            clearWord()
        }
    }
    
    func tapped(){
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe0))
            tap.numberOfTapsRequired = 2
            self.cardHand0.isUserInteractionEnabled = true
            self.cardHand0.addGestureRecognizer(tap)
        
            let tap2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe1))
            tap2.numberOfTapsRequired = 2
            cardHand1.isUserInteractionEnabled = true
            cardHand1.addGestureRecognizer(tap2)
        
            let tap3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe2))
            tap3.numberOfTapsRequired = 2
            cardHand2.isUserInteractionEnabled = true
            cardHand2.addGestureRecognizer(tap3)
        
            let tap4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe3))
            tap4.numberOfTapsRequired = 2
            self.cardHand3.isUserInteractionEnabled = true
            self.cardHand3.addGestureRecognizer(tap4)
        
            let tap5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe4))
            tap5.numberOfTapsRequired = 2
            self.cardHand4.isUserInteractionEnabled = true
            self.cardHand4.addGestureRecognizer(tap5)
    }
    
    @objc func tappedMe0(){
        if ((hand[0].type.rawValue).contains("wild")){
        let alertController = UIAlertController(title: "Wild detected!!!", message: "Enter a letter", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField{ (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let textf0 = (alertController.textFields?[0])! as UITextField
            self.hand[0].name = textf0.text!
        }))
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedMe1(){
        if (hand[1].type.rawValue).contains("wild"){
        let alertController = UIAlertController(title: "Wild detected!!!", message: "Enter a letter", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField{ (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let textf1 = (alertController.textFields?[0])! as UITextField
            self.hand[1].name = textf1.text!
        }))
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedMe2(){
        if (hand[2].type.rawValue).contains("wild"){
        let alertController = UIAlertController(title: "Wild detected!!!", message: "Enter a letter", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField{ (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let textf2 = (alertController.textFields?[0])! as UITextField
            self.hand[2].name = textf2.text!
        }))
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedMe3(){
        if ((hand[3].type.rawValue).contains("wild")){
        let alertController = UIAlertController(title: "Wild detected!!!", message: "Enter a letter", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField{ (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let textf3 = (alertController.textFields?[0])! as UITextField
            self.hand[3].name = textf3.text!
        }))
        self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedMe4(){
         if ((hand[4].type.rawValue).contains("wild")){
        let alertController = UIAlertController(title: "Wild detected!!!", message: "Enter a letter", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField{ (textField) -> Void in
        }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            let textf4 = (alertController.textFields?[0])! as UITextField
            self.hand[4].name = textf4.text!
        }))
        self.present(alertController, animated: true, completion: nil)
         }
    }
    
    func playerTwoTurn(){
        Money.moneyP2 = 0
        var tempArray = [String]()
        let deckChoice = playerTwoStartingDeck.randomElement().name
        for i in playerTwoStartingDeck{
            if(i.name == deckChoice){
                Money.moneyP2 += i.points
                }
            }
            if (Money.moneyP2 == 5){
                Money.scoreP2 += 4
                let alert = UIAlertController(title: "Player 2", message: "Player two has created the word \"\(deckChoice)\" for \(Money.moneyP2) points and bought a \"wildcard\" for 4 points", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            if (Money.moneyP2 >= 2) && (Money.moneyP2 < 5){
                for i in playerTwoBuyDeck{
                    if(i.points == Money.moneyP2){
                        tempArray.append(i.name)
                    }
                }
                if !(tempArray.isEmpty){
                    let choiceTempArray = tempArray.randomElement()
                    let alert = UIAlertController(title: "Player 2", message: "Player two has created the word \"\(deckChoice)\" for \(Money.moneyP2) points and bought the card \"\(choiceTempArray)\"", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    
    func endGame(){
        if (Money.scoreP2 >= 15){
           performSegue(withIdentifier: "endGame", sender: self)
        }
        if (Money.score >= 15){
            performSegue(withIdentifier: "endGame", sender: self)
        }
    }
}

    extension Array{
        func randomElement() -> Element{
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        }
    }
    








