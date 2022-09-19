//
//  ViewController.swift
//  Flashcards
//
//  Created by Yara on 9/13/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel! // question
    @IBOutlet weak var backLabel: UILabel! // answer
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // round the corners
        card.layer.cornerRadius = 20.0
        
        // only clip the labels
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        // add the shadows
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
     
        
        // beautify buttons //
        // give buttons rounded corners
        buttonOne.layer.cornerRadius = 20.0
        buttonOne.clipsToBounds = true
        
        buttonTwo.layer.cornerRadius = 20.0
        buttonTwo.clipsToBounds = true
        
        buttonThree.layer.cornerRadius = 20.0
        buttonThree.clipsToBounds = true

        
        // give buttons border colors
        buttonOne.layer.borderWidth = 3.0
        buttonOne.layer.borderColor = UIColor.orange.cgColor
        
        buttonTwo.layer.borderWidth = 3.0
        buttonTwo.layer.borderColor = UIColor.orange.cgColor
        
        buttonThree.layer.borderWidth = 3.0
        buttonThree.layer.borderColor = UIColor.orange.cgColor
    }


    // logic to show the answer when the card is tapped
    @IBAction func didTapFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true{
            frontLabel.isHidden = false
        }
        else{
            frontLabel.isHidden = true
        }
    }
    
    // hide button when tapped
    @IBAction func didTapButtonOne(_ sender: Any) {
        buttonOne.isHidden = true
    }
    
    // this is right answer!
    @IBAction func didTapButtonTwo(_ sender: Any) {
        if frontLabel.isHidden == true{
            frontLabel.isHidden = false
        }
        else{
            frontLabel.isHidden = true
        }
    }
    
    // hide button when tapped
    @IBAction func didTapButtonThree(_ sender: Any) {
        buttonThree.isHidden = true
    }
}

