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
    @IBOutlet weak private var myTextField: UITextField!
    
    var delegate: SecondScreenViewControllerDelagate?
    
    var secondVCConfigurator = SecondViewControllerConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTestTableView.dataSource = self
        myTextField.delegate = self
        configure(for: secondVCConfigurator)
    }
    
    func configure(for secondVC: SecondViewControllerConfiguration) {
        if secondVC.textForTexfield != nil {
            myTextField.text = secondVC.textForTexfield
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - UITableView Data Source

extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        secondVCConfigurator.nonLocalDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyTableViewCell {
            cell.delegate = self
            if secondVCConfigurator.nonLocalDict[indexPath.row] == false {
                cell.configure(with: false)
            } else {
                cell.configure(with: true)
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
        
        secondVCConfigurator.nonLocalDict[numberOfRow] = switchState
        
        delegate?.configureTextView(text: secondVCConfigurator.nonLocalDict)
        
    }
    
}


