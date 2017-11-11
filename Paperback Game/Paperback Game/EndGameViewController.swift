//
//  EndGameViewController.swift
//  RMiller_Final_Project
//
//  Created by Rob on 2/24/17.
//  Copyright © 2017 Rob. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet var endLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBackgroudImage()
        endMessage()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBackgroudImage(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "endScreen")!)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "endScreen")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    func endMessage(){
        if(Money.score > Money.scoreP2){
            endLabel.text = "Congratulations! Your score is \(Money.score)"
        }else{
            endLabel.text = "You lost! Player two won with a score of \(Money.scoreP2)"
        }
    }

}
