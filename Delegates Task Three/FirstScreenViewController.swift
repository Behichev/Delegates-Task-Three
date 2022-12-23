//
//  ViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

class FirstScreenViewController: UIViewController {
   
    //MARK: - Outlets
    
    @IBOutlet weak private var cellStatesLabel: UITextView!
    @IBOutlet weak private var textFromTextFieldLabel: UILabel!
    
    //MARK: - Variables
    
    private var bunchOfSwitchStates: [Bool] = []
    
    //MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for value in 0...9 {
            bunchOfSwitchStates.append(false)
        }
    }
  
    //MARK: - Actions
    
    @IBAction private func goButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: AppConstants.Identifiers.segueIdentifier, sender: self)
    }
  
    //MARK: - Prepare for seague
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.Identifiers.segueIdentifier {
            if let secondVC = segue.destination as? SecondScreenViewController {
                secondVC.delegate = self
                if let text = textFromTextFieldLabel.text {
                    let configuration = SecondViewControllerConfiguration(bunchOfSwiftStates: bunchOfSwitchStates,
                                                                          textForTexfield: text)
                    secondVC.configure(with: configuration)
                }
                
            }
        }
    }
}

//MARK: - SecondScreenViewControllerDelegate

extension FirstScreenViewController: SecondScreenViewControllerDelagate {
    func switchStateDidChange(state: Bool, index: Int) {
        var textElement = ""
        bunchOfSwitchStates[index] = state
        
        for (index, element) in bunchOfSwitchStates.enumerated() {
            let textValue = element ? "ON" : "OFF"
            textElement += "\(index): \(textValue)\n"
        }
        cellStatesLabel.text = textElement
    }
    
    func sendMessageToLabel(message: String) {
        textFromTextFieldLabel.text = message
    }
}
