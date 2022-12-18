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
    
    private var switchStateDictionary: [Int:Bool] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        for i in 0...9 {
            switchStateDictionary[i] = false
        }
        
    }
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: AppConstants.Identifiers.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.Identifiers.segueIdentifier {
            if let secondVC = segue.destination as? SecondScreenViewController {
                secondVC.delegate = self
                let configuration = SecondViewControllerConfiguration(nonLocalDict: switchStateDictionary,
                                                                      textForTexfield: myTestLabel.text ?? "Label")
                secondVC.configure(with: configuration)
            }
        }
    }
    
}

//MARK: - SecondScreenViewControllerDelegate

extension FirstScreenViewController: SecondScreenViewControllerDelagate {
    
    func sendMessageToLabel(message: String) {
        myTestLabel.text = message
    }
    
    func configureTextView(dictionary: [Int:Bool]) {
        switchStateDictionary = dictionary
        var textElement = ""
        
        for key in switchStateDictionary.keys.sorted(by: <) {
            let textValue = switchStateDictionary[key]! ? "ON" : "OFF"
            textElement += "\(key): \(textValue)\n"
        }
            
        myTestTextView.text = textElement
    }
    
}
