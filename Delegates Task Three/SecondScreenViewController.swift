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
    
    @IBOutlet weak private var delegateTestTableView: UITableView!
    @IBOutlet weak private var myTextField: UITextField!
    
    var delegate: SecondScreenViewControllerDelagate?
    
    private var configuration: SecondViewControllerConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTestTableView.dataSource = self
        myTextField.delegate = self
        myTextField.text = configuration?.textForTexfield
    }
    
    func configure(with configuration: SecondViewControllerConfiguration) {
        self.configuration = configuration
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - UITableView Data Source

extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        configuration?.nonLocalDict.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MyTableViewCell {
            cell.delegate = self
            if configuration?.nonLocalDict[indexPath.row] == false {
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
        
        configuration?.nonLocalDict[numberOfRow] = switchState
        delegate?.configureTextView(text: configuration?.nonLocalDict ?? [:])
        
        
    }
    
}


