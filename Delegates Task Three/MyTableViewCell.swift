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

    @IBOutlet weak var mySwitch: UISwitch!
    
    var delegate: SwitchStatmentDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        delegate?.showSwitchState(cell: self, switchState: mySwitch.isOn)
       
    }
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        delegate?.showSwitchState(cell: self, switchState: mySwitch.isOn)
    }
    
}


