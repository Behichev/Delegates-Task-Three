//
//  MyTableViewCell.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SwitchStatmentDelegate {
    func showSwitchState(switchStatement: Bool ) -> [String]
}

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var mySwitch: UISwitch!
    
    var delegate: SwitchStatmentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        delegate?.showSwitchState(switchStatement: mySwitch.isOn)
    }
    
    
    
}
