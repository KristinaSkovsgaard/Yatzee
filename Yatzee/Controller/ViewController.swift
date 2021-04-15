//
//  ViewController.swift
//  Yatzee
//
//  Created by Kristina Skovsgaard on 05/02/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var diceBtn1: UIButton!
    @IBOutlet weak var diceBtn2: UIButton!
    @IBOutlet weak var diceBtn3: UIButton!
    @IBOutlet weak var diceBtn4: UIButton!
    @IBOutlet weak var diceBtn5: UIButton!
    
    @IBOutlet weak var saved1: UIButton!
    @IBOutlet weak var saved2: UIButton!
    @IBOutlet weak var saved3: UIButton!
    @IBOutlet weak var saved4: UIButton!
    @IBOutlet weak var saved5: UIButton!
    
    @IBOutlet weak var diceLabel: UILabel!
    @IBOutlet weak var rollButton: UIButton!
    
    var diceRoll: Int = 0
    
    var diceSaved:[Int] = []
    
    /*COREDATA*/
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedDiceArray = [DiceItem]()
    var currentDiceArray = [DiceItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*COREDATA*/
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        setTextLabel()
        
        loadData()
        
    }
    
    private func setTextLabel(){
        diceLabel.text = ""
        rollButton.setTitle("Roll", for: .normal)
        diceLabel.text = "Roll the dice three times."
    }
    
    //Item.fectRequest is a default value, if there is none.
    private func loadData(with request: NSFetchRequest<DiceItem> = DiceItem.fetchRequest()){
        /*COREDATA*/
        do{
            savedDiceArray = try context.fetch(request)
            currentDiceArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        if savedDiceArray.count != 5 || currentDiceArray.count != 5{
            //print("Create arrays again")
            createAllDice()
        }
       else{
            setStartButtons()
            //TODO: What happens if 1,2,3,4,5 is saved??
        }
    }
    
    private func createAllDice(){
        //print("CreateAllDice")
        /*CORE DATA*/
        currentDiceArray.removeAll() //Be sure there is only 5 dice in each.
        savedDiceArray.removeAll()
        self.saveAllDice()
        
        let currentDice1 = DiceItem(context:self.context)
        currentDice1.dieNo = 1
        currentDice1.dieDots = 1
        currentDice1.stillRolling = true
        
        let currentDice2 = DiceItem(context:self.context)
        currentDice2.dieNo = 2
        currentDice2.dieDots = 2
        currentDice2.stillRolling = true
        
        let currentDice3 = DiceItem(context:self.context)
        currentDice3.dieNo = 3
        currentDice3.dieDots = 3
        currentDice3.stillRolling = true
        
        let currentDice4 = DiceItem(context:self.context)
        currentDice4.dieNo = 4
        currentDice4.dieDots = 4
        currentDice4.stillRolling = true
        
        let currentDice5 = DiceItem(context:self.context)
        currentDice5.dieNo = 5
        currentDice5.dieDots = 5
        currentDice5.stillRolling = true
        
        self.currentDiceArray.append(currentDice1)
        self.currentDiceArray.append(currentDice2)
        self.currentDiceArray.append(currentDice3)
        self.currentDiceArray.append(currentDice4)
        self.currentDiceArray.append(currentDice5)
        
        let savedDice1 = DiceItem(context:self.context)
        savedDice1.dieNo = 1
        savedDice1.dieDots = 0
        
        let savedDice2 = DiceItem(context:self.context)
        savedDice2.dieNo = 2
        savedDice2.dieDots = 0
        
        let savedDice3 = DiceItem(context:self.context)
        savedDice3.dieNo = 3
        savedDice3.dieDots = 0
        
        let savedDice4 = DiceItem(context:self.context)
        savedDice4.dieNo = 4
        savedDice4.dieDots = 0
        
        let savedDice5 = DiceItem(context:self.context)
        savedDice5.dieNo = 5
        savedDice5.dieDots = 0
        
        self.savedDiceArray.append(savedDice1)
        self.savedDiceArray.append(savedDice2)
        self.savedDiceArray.append(savedDice3)
        self.savedDiceArray.append(savedDice4)
        self.savedDiceArray.append(savedDice5)
        
        self.saveAllDice()
        
        setStartButtons()
    }
    
    private func saveAllDice(){
        /*COREDATA*/
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
    }
    
    private func setStartButtons(){
        diceBtn1.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
        diceBtn2.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
        diceBtn3.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
        diceBtn4.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
        diceBtn5.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
    }
    
//MARK: - Roll Button
    @IBAction func rollPressed(_ sender: UIButton) {
        
        var currentRoll:[DiceItem] = []
        
        for die in currentDiceArray{
            if die.stillRolling{
                currentRoll.append(die)
            }
        }
        //print("Still rolling: \(currentRoll.count)")
        
        if(diceRoll<3){
            diceRoll += 1
            
            for dieRolling in currentRoll{
                
                dieRolling.dieDots = Int16(Int.random(in: 1...6))
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
    
    private func setDieImage(die: DiceItem){
        
        var currentButton: UIButton
        
        switch die.dieNo {
        case 1:
            currentButton = diceBtn1
        case 2:
            currentButton = diceBtn2
        case 3:
            currentButton = diceBtn3
        case 4:
            currentButton = diceBtn4
        case 5:
            currentButton = diceBtn5
        default:
            currentButton = diceBtn1
        }
        
        switch die.dieDots {
        case 1:
            currentButton.setImage(#imageLiteral(resourceName: "DiceOneWhite"), for: .normal)
        case 2:
            currentButton.setImage(#imageLiteral(resourceName: "DiceTwoWhite"), for: .normal)
        case 3:
            currentButton.setImage(#imageLiteral(resourceName: "DiceThreeWhite"), for: .normal)
        case 4:
            currentButton.setImage(#imageLiteral(resourceName: "DiceFourWhite"), for: .normal)
        case 5:
            currentButton.setImage(#imageLiteral(resourceName: "DiveFiveWhite"), for: .normal)
        case 6:
            currentButton.setImage(#imageLiteral(resourceName: "DiceSixWhite"), for: .normal)
        default:
            currentButton.imageView?.image = #imageLiteral(resourceName: "savedbackground")
        }
    }

//MARK: - Dice selected
    @IBAction func diceSelected(_ sender: UIButton) {
        
        if(diceRoll > 0){ //Can't select on start
            sender.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
            saveCurrentDice(no: sender.tag - 1)
        }
        saveAllDice()
    }
    private func saveCurrentDice(no: Int){
        savedDiceArray[no].dieDots = currentDiceArray[no].dieDots
        currentDiceArray[no].stillRolling = false
        setSavedImage()
    }
    
    private func setSavedImage(){
       // print("setSavedImage")
        //print("SetSavedImage with die no: \(die.dieNo) and dots: \(die.dieDots)")
       // var currentSavedButton: UIButton
        
        let showSavedArray = getTempSavedArraySorted()
        
        switch showSavedArray.count {
        case 0:
            saved1.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved2.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved3.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved4.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
        case 1:
            saved1.setImage(getImageforDots(dots: Int(showSavedArray[0].dieDots)), for: .normal)
            saved2.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved3.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved4.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
        case 2:
            saved1.setImage(getImageforDots(dots: Int(showSavedArray[0].dieDots)), for: .normal)
            saved2.setImage(getImageforDots(dots: Int(showSavedArray[1].dieDots)), for: .normal)
            saved3.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved4.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
        case 3:
            saved1.setImage(getImageforDots(dots: Int(showSavedArray[0].dieDots)), for: .normal)
            saved2.setImage(getImageforDots(dots: Int(showSavedArray[1].dieDots)), for: .normal)
            saved3.setImage(getImageforDots(dots: Int(showSavedArray[2].dieDots)), for: .normal)
            saved4.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
        case 4:
            saved1.setImage(getImageforDots(dots: Int(showSavedArray[0].dieDots)), for: .normal)
            saved2.setImage(getImageforDots(dots: Int(showSavedArray[1].dieDots)), for: .normal)
            saved3.setImage(getImageforDots(dots: Int(showSavedArray[2].dieDots)), for: .normal)
            saved4.setImage(getImageforDots(dots: Int(showSavedArray[3].dieDots)), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            
        case 5:
            saved1.setImage(getImageforDots(dots: Int(showSavedArray[0].dieDots)), for: .normal)
            saved2.setImage(getImageforDots(dots: Int(showSavedArray[1].dieDots)), for: .normal)
            saved3.setImage(getImageforDots(dots: Int(showSavedArray[2].dieDots)), for: .normal)
            saved4.setImage(getImageforDots(dots: Int(showSavedArray[3].dieDots)), for: .normal)
            saved5.setImage(getImageforDots(dots: Int(showSavedArray[4].dieDots)), for: .normal)
            
        default:
            saved1.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved2.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved3.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved4.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
            saved5.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
        }
        
    }
    
    private func getImageforDots(dots:Int) -> UIImage?{
        
        switch dots {
        case 1:
            return UIImage(named: "DiceOneWhite.png")
        case 2:
            return UIImage(named: "DiceTwoWhite.png")
        case 3:
            return UIImage(named: "DiceThreeWhite.png")
        case 4:
            return UIImage(named: "DiceFourWhite.png")
        case 5:
            return UIImage(named: "DiveFiveWhite.png")
        case 6:
            return UIImage(named: "DiceSixWhite.png")
        default:
            return UIImage(named: "savedbackground.png")
        }
    }
    
    
//MARK: - saved Dice Selected
    @IBAction func savedDiceSelected(_ sender: UIButton) {
        
        sender.setImage(#imageLiteral(resourceName: "savedbackground"), for: .normal)
        
        if(savedDiceArray.count > 0){
        
            //Temp. array of sorted saved, without 0
            let currentArray = getTempSavedArraySorted()
            
            //Swith saved button pressed
            switch sender.tag {
            case 1:
                print("Current dots: \(currentArray[0].dieDots)")
                setDiceRolling(chosenDie: currentArray[0])
                
            case 2:
                print("Current dots: \(currentArray[1].dieDots)")
                setDiceRolling(chosenDie: currentArray[1])
            
            case 3:
                print("Current dots: \(currentArray[2].dieDots)")
                setDiceRolling(chosenDie: currentArray[2])
             
            case 4:
                print("Current dots: \(currentArray[3].dieDots)")
                setDiceRolling(chosenDie: currentArray[3])
                
            case 5:
                print("Current dots: \(currentArray[4].dieDots)")
                setDiceRolling(chosenDie: currentArray[4])
                
            default:
                print("Current dots: \(currentArray[0].dieDots)")
            }
        }
        
        saveAllDice()
    }
    /*
     Returns savedArray sorted and without 0 dots
     */
    private func getTempSavedArraySorted() -> [DiceItem]{
        var tempArray: [DiceItem] = []
        
        for die in savedDiceArray{
            if die.dieDots > 0 {
                tempArray.append(die)
            }
        }
        
        tempArray.sort(by:{ $0.dieDots < $1.dieDots})
        print("Current temp array: \(tempArray.count)")
        
        return tempArray
    }
    
    private func setDiceRolling(chosenDie: DiceItem){
        for dice in currentDiceArray {
            
            if dice.stillRolling == false{
                
                dice.stillRolling = true
                dice.dieDots = chosenDie.dieDots
                removeFromSaved(dieDots: Int(dice.dieDots))
        
                setDieImage(die: dice)
                break
            }
            
        }
    }
    
    private func removeFromSaved(dieDots: Int){
        
        for die1 in savedDiceArray{
            if dieDots == die1.dieDots{
                print("Found saved to set to 0")
                die1.dieDots = 0
                break
            }
        }
        saveAllDice()
        
        //Update saved button
        setSavedImage()
        
    }
    
}
    


