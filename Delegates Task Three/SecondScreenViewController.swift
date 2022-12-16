//
//  SecondScreenViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SecondScreenViewControllerDelagate {
    func sendMessageToLabel(message: String)
    func configureTextView(text: [Int:Bool])
}

class SecondScreenViewController: UIViewController {
    
    @IBOutlet weak var delegateTestTableView: UITableView!
    @IBOutlet weak var myTextField: UITextField!
    
    var delegate: SecondScreenViewControllerDelagate?
    
    var nonLocalDict: [Int:Bool] = [:]
    
    var textForTexfield: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTestTableView.dataSource = self
        myTextField.delegate = self
        if let textForTexfield {
            myTextField.text = textForTexfield
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - UITableView Data Source

extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nonLocalDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyTableViewCell {
            cell.delegate = self
            
            if nonLocalDict[indexPath.row] == false {
                cell.mySwitch.setOn(false, animated: true)
            } else {
                cell.mySwitch.setOn(true, animated: true)
            }
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
        
        nonLocalDict[numberOfRow] = switchState
        
        delegate?.configureTextView(text: nonLocalDict)
        
    }
    
}


