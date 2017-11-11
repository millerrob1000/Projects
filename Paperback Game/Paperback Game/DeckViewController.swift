//
//  DeckViewController.swift
//  RMiller_Final_Project
//
//  Created by Rob on 2/20/17.
//  Copyright © 2017 Rob. All rights reserved.
//

import UIKit

class DeckViewController: UIViewController {

    @IBOutlet var moneyAvailable: UILabel!
    @IBOutlet var twoCentPile: UIImageView!
    @IBOutlet var threeCentZero: UIImageView!
    @IBOutlet var threeCentTop: UIImageView!
    @IBOutlet var fourCentTop: UIImageView!
    @IBOutlet var fourCentZero: UIImageView!
    @IBOutlet var fiveCentTop: UIImageView!
    @IBOutlet var fiveCentZero: UIImageView!
    @IBOutlet var sixCentTop: UIImageView!
    @IBOutlet var sixCentZero: UIImageView!
    @IBOutlet var sevenCentTop: UIImageView!
    @IBOutlet var sevenCentZero: UIImageView!
    @IBOutlet var eightNineTenTop: UIImageView!
    @IBOutlet var eightNineTenZero: UIImageView!
    @IBOutlet var wild5Deck: UIImageView!
    @IBOutlet var wild8Deck: UIImageView!
    @IBOutlet var wild11Deck: UIImageView!
    @IBOutlet var wild17Deck: UIImageView!
    @IBOutlet var score: UILabel!
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var scorePlayerTwo: UILabel!
    
    var completeDeck = deck
    var twoCentDeck = [Card]()
    var threeCentDeck = [Card]()
    var fourCentDeck = [Card]()
    var fiveCentDeck = [Card]()
    var sixCentDeck = [Card]()
    var sevenCentDeck = [Card]()
    var eightNineTenDeck = [Card]()
    var wild5Cent = wildFiveCent
    var wild8Cent = wildEightCent
    var wild11Cent = wildElevenCent
    var wild17Cent = wildSeventeenCent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score.text = String(Money.score)
        scorePlayerTwo.text = String(Money.scoreP2)
        setupDecks()
        loadBackgroudImage()
        tappedImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tappedImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func returnButton(_ sender: UIButton) {
        Money.index0Score = 0
        Money.index1Score = 0
        Money.index2Score = 0
        Money.index3Score = 0
        Money.index4Score = 0
        Money.index5Score = 0
        Money.money = 0
        moneyAvailable.text = String(Money.money)
        dismiss(animated: true, completion: nil)
    }
    
    func tappedImage(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe0))
            twoCentPile.isUserInteractionEnabled = true
            twoCentPile.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe1))
            threeCentTop.isUserInteractionEnabled = true
            threeCentTop.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe2))
            threeCentZero.isUserInteractionEnabled = true
            threeCentZero.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe3))
            fourCentTop.isUserInteractionEnabled = true
            fourCentTop.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe4))
            fourCentZero.isUserInteractionEnabled = true
            fourCentZero.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe5))
            fiveCentZero.isUserInteractionEnabled = true
            fiveCentZero.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe6))
            fiveCentTop.isUserInteractionEnabled = true
            fiveCentTop.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe7))
            sixCentTop.isUserInteractionEnabled = true
            sixCentTop.addGestureRecognizer(tap7)
        
        let tap8 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe8))
            sixCentZero.isUserInteractionEnabled = true
            sixCentZero.addGestureRecognizer(tap8)
        
        let tap9 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe9))
            sevenCentZero.isUserInteractionEnabled = true
            sevenCentZero.addGestureRecognizer(tap9)
        
        let tap10 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe10))
            sevenCentTop.isUserInteractionEnabled = true
            sevenCentTop.addGestureRecognizer(tap10)
        
        let tap11 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe11))
            eightNineTenTop.isUserInteractionEnabled = true
            eightNineTenTop.addGestureRecognizer(tap11)
        
        let tap12 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe12))
            eightNineTenZero.isUserInteractionEnabled = true
            eightNineTenZero.addGestureRecognizer(tap12)
        
        let tap13 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe13))
            wild5Deck.isUserInteractionEnabled = true
            wild5Deck.addGestureRecognizer(tap13)
        
        let tap14 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe14))
            wild8Deck.isUserInteractionEnabled = true
            wild8Deck.addGestureRecognizer(tap14)
        
        let tap15 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe15))
            wild11Deck.isUserInteractionEnabled = true
            wild11Deck.addGestureRecognizer(tap15)
        
        let tap16 = UITapGestureRecognizer(target: self, action: #selector(DeckViewController.tappedMe16))
            wild17Deck.isUserInteractionEnabled = true
            wild17Deck.addGestureRecognizer(tap16)
    }
    
    @objc func tappedMe0(){
        let amount = self.twoCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "2 Cent Card", message: "This will add the card to your deck and subtract 2 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
            Money.money -= amount
            self.moneyAvailable.text = String(difference)
            playerDeck.append(self.twoCentDeck[0])
            self.twoCentDeck.remove(at: 0)
            self.twoCentPile.image = UIImage(named: self.twoCentDeck[0].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe1(){
        let amount = self.threeCentDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "3 Cent Card", message: "This will add the card to your deck and subtract 3 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.threeCentDeck[1])
                self.threeCentDeck.remove(at: 1)
                self.threeCentTop.image = UIImage(named: self.threeCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe2(){
        let amount = self.threeCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "3 Cent Card", message: "This will add the card to your deck and subtract 3 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.threeCentDeck[0])
                self.threeCentDeck.remove(at: 0)
                self.threeCentZero.image = UIImage(named: self.threeCentDeck[0].type.rawValue)
                self.threeCentTop.image = UIImage(named: self.threeCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe3(){
        let amount = self.fourCentDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "4 Cent Card", message: "This will add the card to your deck and subtract 4 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.fourCentDeck[1])
                self.fourCentDeck.remove(at: 1)
                self.fourCentTop.image = UIImage(named: self.fourCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe4(){
        let amount = self.fourCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "4 Cent Card", message: "This will add the card to your deck and subtract 4 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.fourCentDeck[0])
                self.fourCentDeck.remove(at: 0)
                self.fourCentZero.image = UIImage(named: self.fourCentDeck[0].type.rawValue)
                self.fourCentTop.image = UIImage(named: self.fourCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe5(){
        let amount = self.fiveCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "5 Cent Card", message: "This will add the card to your deck and subtract 5 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.fiveCentDeck[0])
                self.fiveCentDeck.remove(at: 0)
                self.fiveCentZero.image = UIImage(named: self.fiveCentDeck[0].type.rawValue)
                self.fiveCentTop.image = UIImage(named: self.fiveCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe6(){
        let amount = self.fiveCentDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "5 Cent Card", message: "This will add the card to your deck and subtract 5 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.fiveCentDeck[1])
                self.fiveCentDeck.remove(at: 1)
                self.fiveCentTop.image = UIImage(named: self.fiveCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe7(){
        let amount = self.sixCentDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "6 Cent Card", message: "This will add the card to your deck and subtract 6 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.sixCentDeck[1])
                self.sixCentDeck.remove(at: 1)
                self.sixCentTop.image = UIImage(named: self.sixCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe8(){
        let amount = self.sixCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "6 Cent Card", message: "This will add the card to your deck and subtract 6 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.sixCentDeck[0])
                self.sixCentDeck.remove(at: 0)
                self.sixCentZero.image = UIImage(named: self.sixCentDeck[0].type.rawValue)
                self.sixCentTop.image = UIImage(named: self.sixCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe9(){
        let amount = self.sevenCentDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "7 Cent Card", message: "This will add the card to your deck and subtract 7 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.sixCentDeck[0])
                self.sevenCentDeck.remove(at: 0)
                self.sevenCentZero.image = UIImage(named: self.sevenCentDeck[0].type.rawValue)
                self.sevenCentTop.image = UIImage(named: self.sevenCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe10(){
        let amount = self.sevenCentDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "7 Cent Card", message: "This will add the card to your deck and subtract 7 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.sevenCentDeck[1])
                self.sevenCentDeck.remove(at: 1)
                self.sevenCentTop.image = UIImage(named: self.sevenCentDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe11(){
        let amount = self.eightNineTenDeck[1].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "\(eightNineTenDeck[1].cost) Cent Card", message: "This will add the card to your deck and subtract \(eightNineTenDeck[1].cost) cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.eightNineTenDeck[1])
                self.eightNineTenDeck.remove(at: 1)
                self.eightNineTenTop.image = UIImage(named: self.eightNineTenDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe12(){
        let amount = self.eightNineTenDeck[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "\(eightNineTenDeck[0].cost) Cent Card", message: "This will add the card to your deck and subtract \(eightNineTenDeck[1].cost) cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                playerDeck.append(self.eightNineTenDeck[0])
                self.eightNineTenDeck.remove(at: 0)
                self.eightNineTenZero.image = UIImage(named: self.eightNineTenDeck[0].type.rawValue)
                self.eightNineTenTop.image = UIImage(named: self.eightNineTenDeck[1].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe13(){
        let amount = self.wild5Cent[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "5 Cent Card", message: "This will add the card to your deck and subtract 5 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                Money.score += self.wild5Cent[0].endGamePoint
                playerDeck.append(self.wild5Cent[0])
                self.wild5Cent.remove(at: 0)
                self.wild5Deck.image = UIImage(named: self.wild5Cent[0].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe14(){
        let amount = self.wild8Cent[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "8 Cent Card", message: "This will add the card to your deck and subtract 8 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                Money.score += self.wild8Cent[0].endGamePoint
                playerDeck.append(self.wild8Cent[0])
                self.wild8Cent.remove(at: 0)
                self.wild8Deck.image = UIImage(named: self.wild8Cent[0].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe15(){
        let amount = self.wild11Cent[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "11 Cent Card", message: "This will add the card to your deck and subtract 11 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                Money.score += self.wild11Cent[0].endGamePoint
                playerDeck.append(self.wild11Cent[0])
                self.wild11Cent.remove(at: 0)
                self.wild11Deck.image = UIImage(named: self.wild11Cent[0].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tappedMe16(){
        let amount = self.wild17Cent[0].cost
        let difference = Money.money - amount
        
        let alertController = UIAlertController(title: "17 Cent Card", message: "This will add the card to your deck and subtract 17 cents from your available money", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            if amount > Money.money{
                let alertController = UIAlertController(title: "ERROR!", message: "You don't have enough money to buy this card!", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }else{
                Money.money -= amount
                self.moneyAvailable.text = String(difference)
                Money.score += self.wild17Cent[0].endGamePoint
                playerDeck.append(self.wild17Cent[0])
                self.wild17Cent.remove(at: 0)
                self.wild17Deck.image = UIImage(named: self.wild17Cent[0].type.rawValue)
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func loadBackgroudImage(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    func setupDecks(){
        completeDeck.shuffle()
        sort()
        moneyAvailable.text = String(Money.money)
        twoCentPile.image = UIImage(named: twoCentDeck[0].type.rawValue)
        threeCentZero.image = UIImage(named: threeCentDeck[0].type.rawValue)
        threeCentTop.image = UIImage(named: threeCentDeck[1].type.rawValue)
        fourCentZero.image = UIImage(named: fourCentDeck[0].type.rawValue)
        fourCentTop.image = UIImage(named: fourCentDeck[1].type.rawValue)
        fiveCentZero.image = UIImage(named: fiveCentDeck[0].type.rawValue)
        fiveCentTop.image = UIImage(named: fiveCentDeck[1].type.rawValue)
        sixCentZero.image = UIImage(named: sixCentDeck[0].type.rawValue)
        sixCentTop.image = UIImage(named: sixCentDeck[1].type.rawValue)
        sevenCentTop.image = UIImage(named: sevenCentDeck[1].type.rawValue)
        sevenCentZero.image = UIImage(named: sevenCentDeck[0].type.rawValue)
        eightNineTenTop.image = UIImage(named: eightNineTenDeck[1].type.rawValue)
        eightNineTenZero.image = UIImage(named: eightNineTenDeck[0].type.rawValue)
        wild5Deck.image = UIImage(named: wild5Cent[0].type.rawValue)
        wild8Deck.image = UIImage(named: wild8Cent[0].type.rawValue)
        wild11Deck.image = UIImage(named: wild11Cent[0].type.rawValue)
        wild17Deck.image = UIImage(named: wild17Cent[0].type.rawValue)
    }
    
    func sort(){
        for i in completeDeck{
            if i.cost == 2{
                twoCentDeck.append(i)
            }
            if i.cost == 3{
                threeCentDeck.append(i)
            }
            if i.cost == 4{
                fourCentDeck.append(i)
            }
            if i.cost == 5{
                fiveCentDeck.append(i)
            }
            if i.cost == 6{
                sixCentDeck.append(i)
            }
            if i.cost == 7{
                sevenCentDeck.append(i)
            }
            if i.cost > 7{
                eightNineTenDeck.append(i)
            }
        }
    }
}
