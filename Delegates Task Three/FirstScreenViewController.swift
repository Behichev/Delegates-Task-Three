//
//  ViewController.swift
//  Delegates Task Three
//
//  Created by Ivan Behichev on 13.12.2022.
//

import UIKit
protocol TestSwitchDelegate {
    func testSwitchValueChanged(_ : UISwitch)
}
class FirstScreenViewController: UIViewController {

    @IBOutlet weak var myTestTextView: UITextView!
    @IBOutlet weak var myTestLabel: UILabel!
    
    var delegate: TestSwitchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSecondScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondScreen" {
            if let secondVC = segue.destination as? SecondScreenViewController {
                secondVC.delegate = self
            }
        }
    }
    
}

//MARK: - SecondScreenViewControllerDelegate

extension FirstScreenViewController: SecondScreenViewControllerDelagate {
    
    func sendMessageToLabel(message: String) {
        myTestLabel.text = message
    }
    
    func configureTextView(text: [Int:String]) {
        var textArray: [String] = []
        
        for (key, value) in text {
            textArray.append("\(key). \(del)")
        }

        var textElement = ""
       
        for a in textArray.sorted(by: {$0 < $1}) {
            textElement =  textElement + a + "\n"
        }
        
        myTestTextView.text = textElement
    }
    
}

/*
 Sasha_A, [12 груд. 2022 р., 10:28:15]:
 на первом экране есть лейба и text view, на втором экране есть text field и таблица
 когда на втором экране меняется text field, это летит сразу на первый экран в лейбу

 на первом в text view изначально, например, 10 строк, такого формата:
 1: off
 2: off
 и т.д.,
 они показываютс изначальное состояние UISwitch в каждой ячейке на втором экране
 когда на втором экране меняется какой-то UISwitch, то на первом моментально обновляется этот список, например включил второй, на первом сразу стало 2: on

 ну и когда вернулся на первый, увидел каке-то состояние списка, что, например, второй включен, то при переходе на экран с таблицей, и там второй тоже сразу должен быть активирован

 потом еще сильнее можно усложнить задачу, логически есть два экрана, и один список состояний, и на первом экране еще есть UISegmentedControl у которого три состояния, табилца, коллекция, стеквью, и в зависимости от того что нажато на первом экране, при переходе на второй такой UI элемент и будет отображать список (но при этом всегда работать через один делегат)

 Sasha_A, [12 груд. 2022 р., 10:45:53]:
 Ещё можно на первом добавить UISwitch который активирует работу или по делегатам или по замыканию) я ещё несколько усложнений придумал, но можно начать хотя бы с этого
 
 
 Ну и подсказка, что бы дело пошло быстрее, в словаре сразу должно быть 10 значений, изначально все off, и при нажатии нужный ключ меняется на противоположный
 */
