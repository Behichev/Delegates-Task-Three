//
//  ViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak private var myTestTextView: UITextView!
    @IBOutlet weak private var myTestLabel: UILabel!
   
    var firstVCConfigurator = FirstScreenViewControllerConfigurator()
    
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
                secondVC.secondVCConfigurator.nonLocalDict = firstVCConfigurator.dictionary
                if myTestLabel.text != nil {
                    secondVC.secondVCConfigurator.textForTexfield = myTestLabel.text
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
       
        firstVCConfigurator.dictionary = text
        
        for (key, value) in firstVCConfigurator.dictionary {
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
