//
//  SecondScreenViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SecondScreenViewControllerDelagate {
    func sendMessageToLabel(message: String)
    func switchStateDidChange(state: Bool, index: Int)
}

class SecondScreenViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak private var delegateTestTableView: UITableView!
    @IBOutlet weak private var myTextField: UITextField!
   
    //MARK: - Variables
    
    var delegate: SecondScreenViewControllerDelagate?
    
    private var configuration: SecondViewControllerConfiguration?
    private var items: [ItemState] = []
    private var cellTitle = ""
    private var cellColor: UIColor = .red
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTestTableView.dataSource = self
        myTextField.delegate = self
        myTextField.text = configuration?.textForTexfield
    }
    
    //MARK: - Functions
    
    func configure(with configuration: SecondViewControllerConfiguration) {
        self.configuration = configuration
        let configureItemsArray = configuration.bunchOfSwiftStates.enumerated().map ({ (index, element) in
            if element {
                cellColor = .green
                cellTitle = "ON"
            } else {
                cellTitle = "OFF"
            }
            return ItemState(id: index, state: element, cellTitle: cellTitle, cellBackgroundColor: cellColor)
        })
        items = configureItemsArray
    }
    
    //MARK: - Actions
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

//MARK: - UITableView Data Source

extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Identifiers.cellIdentifier) as? MyTableViewCell {
            cell.delegate = self
            let items = items[indexPath.row]
            cell.configure(with: items)
            cell.backgroundColor = items.cellBackgroundColor
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
    func changeSwitchState(index: Int, switchState: Bool) {
        items[index].state = switchState
        configuration?.bunchOfSwiftStates[index] = switchState
        delegate?.switchStateDidChange(state: switchState, index: index)
    }
}
