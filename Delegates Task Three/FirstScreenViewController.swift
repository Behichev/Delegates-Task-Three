//
//  ViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var myTestTextView: UITextView!
    @IBOutlet weak var myTestLabel: UILabel!
    
    var dict: [Int:Bool] = [
        0:false, 1:false, 2:false, 3:false, 4:false, 5:false, 6:false, 7:false, 8:false, 9:false
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen" {
            if let secondVC = segue.destination as? SecondScreenViewController {
                secondVC.delegate = self
                secondVC.nonLocalDict = dict
                if myTestLabel.text != nil {
                    secondVC.textForTexfield = myTestLabel.text
                }
                
            }
        }
    }
    
}

//MARK: - SecondScreenViewControllerDelegate

extension FirstScreenViewController: SecondScreenViewControllerDelagate {
    
    func sendMessageToLabel(message: String) {
        myTestLabel.text = message
    }
    
    func configureTextView(text: [Int:Bool]) {
        var textArray: [String] = []
       
        dict = text
        
        for (key, value) in dict {
            if value {
                textArray.append("\(key). is On")
            } else {
                textArray.append("\(key). is Off")
            }
            
        }

        var textElement = ""
       
        for a in textArray.sorted(by: { $0 < $1 }) {
            textElement =  textElement + a + "\n"
        }
        
        myTestTextView.text = textElement
    }
    
}
