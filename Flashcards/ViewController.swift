//
//  ViewController.swift
//  Flashcards
//
//  Created by Yara Musad on 9/13/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var frontLabel: UILabel! // question
    @IBOutlet weak var backLabel: UILabel! // answer
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // array to hold cards
    var flashcards = [Flashcard]()
    
    // current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        readSavedFlashcards()
        
        // add first flashcard if there aren't any already saved in disk
        if flashcards.count == 0{
            updateFlashcard(question: "What is the capital of Sudan?", answer: "Khartoum", isExisting: false)
        } else {
            updateLabels()
            
            updateNextPrevButtons()
        }
        
//
//         beautify the cards
//         round the corners
        card.layer.cornerRadius = 20.0

        // only clip the labels
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true

        // add the shadows
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                    self.card.alpha = 1.0
                    self.card.transform = CGAffineTransform.identity
                   
                })
    }
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }

    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if (self.frontLabel.isHidden == false){
                self.frontLabel.isHidden = true
            }
            else if (self.frontLabel.isHidden == true){
                self.frontLabel.isHidden = false
            }
        })
    }
    
    
    func animateCardOutForNext() {
        
        // move the card to LEFT
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: {
            finished in
           
            self.updateLabels()
           
            self.animateCardInForNext()
        })
    }
    
    
    func animateCardInForNext() {
        
        // start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        // animate card going back to it's original position
        UIView.animate(withDuration: 0.3){ self.card.transform = CGAffineTransform.identity}
        
    }
    
    
    func animateCardOutForPrev() {
        
        // move the card to the RIGHT
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: {
            finished in
            
            self.updateLabels()
           
            self.animateCardInForPrev()
        })
    }
    
    
    func animateCardInForPrev() {
        
        // start on the left side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        // animate card going back to it's original position
        UIView.animate(withDuration: 0.3){ self.card.transform = CGAffineTransform.identity}

    }
    

    @IBAction func didTapOnPrev(_ sender: Any) {
       
        // updateIndex
        currentIndex = currentIndex - 1
       
        updateNextPrevButtons()
    
        animateCardOutForPrev()
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
       // updateIndex
        currentIndex = currentIndex + 1
        
        updateNextPrevButtons()
        
        animateCardOutForNext()
    }
    
    
    func saveAllFlashcardsToDisk() {
        
        // convert array to dict
        let dictionaryArray = flashcards.map{(card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        // save array to disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults!")
    }
    
    
    func readSavedFlashcards() {
        // read dict array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            // we know forsure there is a dict array
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)}
            
            // put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    

    func updateLabels () {
            let currentFlashcard = flashcards[currentIndex]

            frontLabel.text = currentFlashcard.question
            backLabel.text = currentFlashcard.answer
        }
    
    
    func updateNextPrevButtons() {
        
        // disable next button if at the end
            if currentIndex == flashcards.count - 1 {
                nextButton.isEnabled = false
            } else {
                nextButton.isEnabled = true
            }
            
        // disable prev button if at the beginning
            if currentIndex == 0 {
                prevButton.isEnabled = false
            } else {
                prevButton.isEnabled = true
            }
        }
    
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            (deleteAction) in self.deleteCurrentFlashcard()
            
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    

    func deleteCurrentFlashcard() {
        
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        if isExisting {
            print(currentIndex)
            flashcards[currentIndex] = flashcard
        } else {
            
            flashcards.append(flashcard)
            
            // output to console
            print("Added new flashcard")
            print("We now have \(flashcards.count) flashcards")
               
               currentIndex = flashcards.count - 1
               print("Our current index is \(currentIndex)")
           }
            
            updateNextPrevButtons()
            
            updateLabels()
            
            saveAllFlashcardsToDisk()
            
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
}

