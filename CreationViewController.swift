//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Yara on 10/3/22.
//

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }

    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        let alert = UIAlertController (title: "Missing text", message: "You must enter both a question and an answer.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        // check if text fields are empty
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            present(alert, animated: true)
        } else {
            var isExisting = false
            
            if (initialQuestion != nil){
                isExisting = true
            }
            
            // call the update function
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, isExisting:isExisting )
            
            dismiss(animated:true)
        }
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated:true)
    }
    
}
