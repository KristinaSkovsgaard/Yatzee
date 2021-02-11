//
//  ViewController.swift
//  Yatzee
//
//  Created by Kristina Skovsgaard on 05/02/2021.
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
    
    var currentDice1 = Die(dieNo: 1, dieDots: 1)
    var currentDice2 = Die(dieNo: 2, dieDots: 2)
    var currentDice3 = Die(dieNo: 3, dieDots: 3)
    var currentDice4 = Die(dieNo: 4, dieDots: 4)
    var currentDice5 = Die(dieNo: 5, dieDots: 5)
    
    var savedDice1 = Die(dieNo: 1, dieDots: 0)
    var savedDice2 = Die(dieNo: 2, dieDots: 0)
    var savedDice3 = Die(dieNo: 3, dieDots: 0)
    var savedDice4 = Die(dieNo: 4, dieDots: 0)
    var savedDice5 = Die(dieNo: 5, dieDots: 0)
    
    var diceSaved:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        diceLabel.text = ""
        rollButton.setTitle("Roll", for: .normal)
        
        diceLabel.text = "Roll the dice three times."
        
    }
    

    @IBAction func rollPressed(_ sender: UIButton) {
        
        let rollButtons = [currentDice1, currentDice2, currentDice3, currentDice4, currentDice5]
        
        var currentRoll:[Die] = []
        
        for die in rollButtons{
            if die.stillRolling{
                currentRoll.append(die)
            }
        }
        print("Still rolling: \(currentRoll.count)")
        
        if(diceRoll<3){
            diceRoll += 1
            
            for dieRolling in currentRoll{
                
                dieRolling.dieDots = Int.random(in: 1...6)
                setDieImage(die: dieRolling)
            }
            
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
        
        if(diceRoll > 0){
            sender.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
            switch sender.tag {
            case 1:
                savedDice1.dieDots = currentDice1.dieDots
                setSavedImage(die: savedDice1)
                currentDice1.stillRolling = false
                
            case 2:
                savedDice2.dieDots = currentDice2.dieDots
                setSavedImage(die: savedDice2)
                currentDice2.stillRolling = false
            case 3:
                savedDice3.dieDots = currentDice3.dieDots
                setSavedImage(die: savedDice3)
                currentDice3.stillRolling = false
            case 4:
                savedDice4.dieDots = currentDice4.dieDots
                setSavedImage(die: savedDice4)
                currentDice4.stillRolling = false
            case 5:
                savedDice5.dieDots = currentDice5.dieDots
                setSavedImage(die: savedDice5)
                currentDice5.stillRolling = false
            default:
                print("Error in diceSelected")
            }
        
        }
    }
    
    func setSavedImage(die: Die){
        print("SetSavedImage with die no: \(die.dieNo) and dots: \(die.dieDots)")
        var currentSavedButton: UIButton

        switch die.dieNo {
        case 1:
            currentSavedButton = saved1
        case 2:
            currentSavedButton = saved2
        case 3:
            currentSavedButton = saved3
        case 4:
            currentSavedButton = saved4
        case 5:
            currentSavedButton = saved5
        default:
            currentSavedButton = saved1
        }
        
        switch die.dieDots {
        case 1:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceOne"), for: .normal)
        case 2:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceTwo"), for: .normal)
        case 3:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceThree"), for: .normal)
        case 4:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceFour"), for: .normal)
        case 5:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceFive"), for: .normal)
        case 6:
            currentSavedButton.setImage(#imageLiteral(resourceName: "DiceSix"), for: .normal)
        default:
            currentSavedButton.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
        }
        
    }
    
    func setDieImage(die: Die){
        
        var currentButton: UIButton
        
        switch die.dieNo {
        case 1:
            currentButton = dice1
        case 2:
            currentButton = dice2
        case 3:
            currentButton = dice3
        case 4:
            currentButton = dice4
        case 5:
            currentButton = dice5
        default:
            currentButton = dice1
        }
        
        switch die.dieDots {
        case 1:
            currentButton.setImage(#imageLiteral(resourceName: "DiceOne"), for: .normal)
        case 2:
            currentButton.setImage(#imageLiteral(resourceName: "DiceTwo"), for: .normal)
        case 3:
            currentButton.setImage(#imageLiteral(resourceName: "DiceThree"), for: .normal)
        case 4:
            currentButton.setImage(#imageLiteral(resourceName: "DiceFour"), for: .normal)
        case 5:
            currentButton.setImage(#imageLiteral(resourceName: "DiceFive"), for: .normal)
        case 6:
            currentButton.setImage(#imageLiteral(resourceName: "DiceSix"), for: .normal)
        default:
            currentButton.imageView?.image = #imageLiteral(resourceName: "savedbackground")
        }
    }
}
    


