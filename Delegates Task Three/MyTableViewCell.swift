//
//  MyTableViewCell.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SwitchStatmentDelegate {
    func showSwitchState(cell: MyTableViewCell, switchState: Bool)
}

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak private var mySwitch: UISwitch!
 
    var delegate: SwitchStatmentDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    func configure(with state: Bool) {
            if state {
                mySwitch.setOn(true, animated: true)
            } else {
                mySwitch.setOn(false, animated: true)
            }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        delegate?.showSwitchState(cell: self, switchState: mySwitch.isOn)
       
    }
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        delegate?.showSwitchState(cell: self, switchState: mySwitch.isOn)
    }
    
}


