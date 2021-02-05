//
//  ViewController.swift
//  Yatzee
//
//  Created by App og Blog on 05/02/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dice1: UIButton!
    @IBOutlet weak var dice2: UIButton!
    @IBOutlet weak var dice3: UIButton!
    @IBOutlet weak var dice4: UIButton!
    @IBOutlet weak var dice5: UIButton!
    
    @IBOutlet weak var saved1: UIButton!
    @IBOutlet weak var saved2: UIButton!
    @IBOutlet weak var saved3: UIButton!
    @IBOutlet weak var saved4: UIButton!
    @IBOutlet weak var saved5: UIButton!
    
    @IBOutlet weak var diceLabel: UILabel!
    @IBOutlet weak var rollButton: UIButton!
    
    var diceRoll: Int = 0
    
    var currentDice1: UIImage?
    var currentDice2: UIImage?
    var currentDice3: UIImage?
    var currentDice4: UIImage?
    var currentDice5: UIImage?
    
    var diceSaved:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diceLabel.text = ""
        rollButton.setTitle("Roll", for: .normal)
        
        diceLabel.text = "Roll the dice three times."
        
        
        
    }
    

    @IBAction func rollPressed(_ sender: UIButton) {
        
        if(diceRoll<3){
            diceRoll += 1
            
            
            //let rollNumbers = [1,2,3,4,5,6]
            
            let diceArray = [#imageLiteral(resourceName: "DiceOne"),#imageLiteral(resourceName: "DiceTwo"),#imageLiteral(resourceName: "DiceThree"),#imageLiteral(resourceName: "DiceFour"),#imageLiteral(resourceName: "DiceFive"),#imageLiteral(resourceName: "DiceSix")]
            
            currentDice1 = diceArray.randomElement()
            dice1.imageView?.image = currentDice1
            
            currentDice2 = diceArray.randomElement()
            dice2.imageView?.image = currentDice2
            currentDice3 = diceArray.randomElement()
            dice3.imageView?.image = currentDice3
            currentDice4 = diceArray.randomElement()
            dice4.imageView?.image = currentDice4
            currentDice5 = diceArray.randomElement()
            dice5.imageView?.image = currentDice5
            
            if(diceRoll == 3){
                diceLabel.text = "Roll \(diceRoll): Score your roll on the scorecard."
                rollButton.setTitle("Score", for: .normal)
            }
            else{
                diceLabel.text = "Roll \(diceRoll): Select the dice you want to save."
            }
        }
        else {
           // diceLabel.text = "You haved rolled 3 times. Save to the scorecard."
        }
        
    }
    
    @IBAction func diceSelected(_ sender: UIButton) {
        
        sender.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
        
        switch sender.tag {
        case 1:
            print("tag 1")
            saved1.setImage(currentDice1, for: .normal)

        case 2:
            print("tag 2")
            saved2.setImage(currentDice2, for: .normal)
        case 3:
            print("tag 3")
            saved3.setImage(currentDice3, for: .normal)
        case 4:
            print("tag 4")
            saved4.setImage(currentDice4, for: .normal)
        case 5:
            print("tag 5")
            saved5.setImage(currentDice5, for: .normal)
        default:
            print("Error")
        }
        
        //let image = sender.currentTitle
        
        
        
    
        
        //let image = sender.currentImage
        //print("image: \(String(describing: image))")
        
        
    }
    /* @objc func diceImageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController

            let currentView = gesture.view
            print(dice1.image.)
            
            }
    }*/
}
    


