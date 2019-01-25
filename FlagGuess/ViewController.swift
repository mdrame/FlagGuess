//
//  ViewController.swift
//  FlagGuess
//
//  Created by MO on 1/24/19.
//  Copyright © 2019 MO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var countriesArray = [String]()
    var rightScore = 0
    var totalQuestionss = 0 // with two ss
    var correctScore = 0
    var wrongScore = 0
    
    // individual buttons IBOutlets
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    
    // grouped array buttons IBOutlets
    
    @IBOutlet var buttons: [UIButton]!
    
    // result label
    @IBOutlet weak var result: UILabel!
    
    // UIView and it objects OUTlets
    
    @IBOutlet weak var subViewIBOutlet: UIView!
    
    @IBOutlet weak var passed: UILabel!
    
    @IBOutlet weak var failed: UILabel!
    
    @IBOutlet weak var totalQuestions: UILabel!
    
    func customeButton() {
        
        for button in buttons {
            
           
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 5, height: 0)
            button.layer.shadowRadius = 10
            button.layer.shadowOpacity = 0.4
            
            subViewIBOutlet.layer.cornerRadius = 20
            subViewIBOutlet.layer.shadowColor = UIColor.black.cgColor
            subViewIBOutlet.layer.shadowOffset = CGSize(width: 5, height: 0)
            subViewIBOutlet.layer.shadowRadius = 10
            subViewIBOutlet.layer.shadowOpacity = 0.9
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customeButton() // custome buttons layout edits
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        
        for item in items {
            
            if item.hasPrefix("Flag") {
                
                countriesArray.append(item)
            }
   
        }
        
       // print(countriesArray) // testing to see if filemanager/path found countries flag
        
        askQuestion()
   
    } // viewdid load ends here
    
    func askQuestion() {
        
        countriesArray.shuffle() // shufle country arry ever time this function called
        
        one.setBackgroundImage(UIImage(named: countriesArray[0]), for: .normal)
        two.setBackgroundImage(UIImage(named: countriesArray[1]), for: .normal)
        three.setBackgroundImage(UIImage(named: countriesArray[2]), for: .normal)
        
        correctScore = Int.random(in: 0...2) // assigned correct score a random number b/w 0 to 2
        
        title = countriesArray[correctScore] // set the navigation titile to a country name from the countries array
        
 
    }
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        
        
        // if button press if equal to one of thos
        switch sender.tag {
            
        case correctScore:
            
         
           // sender.correctButtonAnimationFlash()
            
            result.text = " Correct "
            rightScore = rightScore + 1
            totalQuestionss = totalQuestionss + 1
            passed.text = "\(rightScore)"
            totalQuestions.text = "\(totalQuestionss)"
            askQuestion()
       
        default:
            
            sender.wrongButtonAnimationShake()
            
            result.text = " Wrong "
            wrongScore = wrongScore + 1
            totalQuestionss = totalQuestionss + 1
            failed.text = "\(wrongScore)"
            totalQuestions.text = "\(totalQuestionss)"

             // UI alert or something
           // askQuestion() // do not uncomment. for testing purpose only
        }
        
        
    }
    
    
    @IBAction func nextAndPreviousButton(_ sender: UIButton) {
        
        
        
        
        
        
    }
    
    
    
    
    
    

    
    


}



extension UIButton {  // button animation  code
    
    func correctButtonAnimationFlash() {
        
        let flashButton = CABasicAnimation(keyPath: "opercity")
        flashButton.duration = 0.3
        flashButton.fromValue = 1
        flashButton.toValue = 0.1
        flashButton.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flashButton.autoreverses = true
        flashButton.repeatCount = 1
        
        layer.add(flashButton, forKey: nil)
  
    }
    
    func wrongButtonAnimationShake() {
        
        let shakeButton = CABasicAnimation(keyPath: "position")
        shakeButton.duration = 0.1
        shakeButton.repeatCount = 2
        shakeButton.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shakeButton.fromValue = fromValue
        shakeButton.toValue = toValue
        
        layer.add(shakeButton, forKey: nil)
        
        
        
    }
    
    
    
    
    
    
    
}

