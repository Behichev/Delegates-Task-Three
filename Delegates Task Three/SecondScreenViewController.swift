//
//  SecondScreenViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SecondScreenViewControllerDelagate {
    func sendMessageToLabel(message: String)
}

class SecondScreenViewController: UIViewController {
    
    @IBOutlet weak var delegateTestTableView: UITableView!
    @IBOutlet weak var myTextField: UITextField!
    
    var delegate: SecondScreenViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTestTableView.dataSource = self
        myTextField.delegate = self
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - UITableView Data Source

extension SecondScreenViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyTableViewCell {
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
}

//MARK: - UITextField Delegate

extension SecondScreenViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            delegate.sendMessageToLabel(message: text)
        }
    }
    
}

//MARK: - SwitchStatmentDelegate

extension SecondScreenViewController: SwitchStatmentDelegate {
    
    func showSwitchState(switchStatement: Bool) -> [String] {
        var array: [String] = []
        
        if switchStatement == true {
            array.append("is On")
        } else {
            array.append("is Off")
        }
        
        return array
        
    }
    
}


