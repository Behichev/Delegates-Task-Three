//
//  MyTableViewCell.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

protocol SwitchStatmentDelegate {
    func changeSwitchState(index: Int, switchState: Bool)
}

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var mySwitch: UISwitch!
    
    var delegate: SwitchStatmentDelegate?
    
    private var cellIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with state: Bool, for index: Int) {
        mySwitch.setOn(state, animated: true)
        cellIndex = index
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction private func valueChanged(_ sender: UISwitch) {
        delegate?.changeSwitchState(index: cellIndex ?? 0, switchState: mySwitch.isOn)
    }
    
}


