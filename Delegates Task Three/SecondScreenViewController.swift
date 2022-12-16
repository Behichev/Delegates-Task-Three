//
//  SecondScreenViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SecondScreenViewControllerDelagate {
    func sendMessageToLabel(message: String)
    func configureTextView(text: [Int:String])
}

class SecondScreenViewController: UIViewController {
    
    @IBOutlet weak var delegateTestTableView: UITableView!
    @IBOutlet weak var myTextField: UITextField!
    
    var delegate: SecondScreenViewControllerDelagate?
    var nonLocalDict: [Int:String] = [0:"off", 1:"off", 2:"off", 3:"off", 4:"off", 5:"off", 6:"off", 7:"off", 8:"off", 9:"off"]
    
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
            delegate?.sendMessageToLabel(message: text)
        }
    }
    
}

//MARK: - SwitchStatmentDelegate

extension SecondScreenViewController: SwitchStatmentDelegate {
    
    func showSwitchState(cell: MyTableViewCell, switchState: Bool){
    
        guard let numberOfRow = delegateTestTableView.indexPath(for: cell)?.row else { return }
    
            let mySwitch: String = {
                if switchState {
                    return "On"
                } else {
                    return "Off"
                }
            }()
        
        nonLocalDict[numberOfRow] = mySwitch
        print(nonLocalDict)
        
        delegate?.configureTextView(text: nonLocalDict)
        
    }
    
}


