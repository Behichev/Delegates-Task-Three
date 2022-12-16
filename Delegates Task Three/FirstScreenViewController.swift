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
    
    var dict: [Int:String] = [0:"Off", 1:"Off", 2:"Off", 3:"Off", 4:"Off", 5:"Off", 6:"Off", 7:"Off", 8:"Off", 9:"Off"]
   
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
            }
        }
    }
    
}

//MARK: - SecondScreenViewControllerDelegate

extension FirstScreenViewController: SecondScreenViewControllerDelagate {
    
    func sendMessageToLabel(message: String) {
        myTestLabel.text = message
    }
    
    func configureTextView(text: [Int:String]) {
        var textArray: [String] = []
       
        dict = text
        print(dict)
        for (key, value) in text {
            textArray.append("\(key). \(value)")
        }

        var textElement = ""
       
        for a in textArray.sorted(by: {$0 < $1}) {
            textElement =  textElement + a + "\n"
        }
        
        myTestTextView.text = textElement
    }
    
}
