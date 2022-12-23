//
//  MyTableViewCell.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit

//MARK: - Protocol

protocol SwitchStatmentDelegate {
    func changeSwitchState(index: Int, switchState: Bool)
}

class MyTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak private var cellTitile: UILabel!
    @IBOutlet weak private var mySwitch: UISwitch!
    
    //MARK: - Variables
    
    var delegate: SwitchStatmentDelegate?
    
    private var cellIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Functions
    
    func configure(with item: ItemState) {
        mySwitch.setOn(item.state, animated: true)
        cellIndex = item.id
        cellTitile.text = item.cellTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Actions
    
    @IBAction private func valueChanged(_ sender: UISwitch) {
        if let cellIndex {
            delegate?.changeSwitchState(index: cellIndex, switchState: mySwitch.isOn)
        }
    }
}
