//
//  ViewController.swift
//  Prework
//
//  Created by Jay on 2022/7/21.
//

import UIKit

class ViewController: UIViewController {

    struct keys {
        static let key1 = "percentage1"
        static let key2 = "percentage2"
        static let key3 = "percentage3"
        static let key4 = "money"
        static let key5 = "DarkModeButtom"
        static let key6 = "PartyNum"
    }
    
    let storage = UserDefaults.standard
    
    @IBOutlet weak var partyNumSwitcher: UIStepper!
    @IBOutlet weak var partyNum: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var perPersonMoney: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPersentages = [storage.double(forKey: keys.key1),storage.double(forKey: keys.key2),storage.double(forKey: keys.key3)]
        let tip = bill * tipPersentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        updatePerPersonMoney(total: total)
    }
    func updateTitle(){
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key1)*100) + "%", forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key2)*100) + "%", forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key3)*100) + "%", forSegmentAt: 2)
    }
    @IBAction func ChangePartySize(_ UIStepper: UIStepper) {
        storage.setValue(UIStepper.value, forKey: keys.key6)
        partyNum.text = String(format :"%.0f", UIStepper.value)
        calculateTip(UIStepper)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        perPersonMoney.textAlignment=NSTextAlignment.right
        partyNumSwitcher.minimumValue = 1
        partyNumSwitcher.value = storage.double(forKey: keys.key6)
        partyNum.text = String(format :"%.0f", partyNumSwitcher.value)
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y:billAmountTextField.frame.height - 1), size: CGSize(width: billAmountTextField.frame.width, height: 1))
        bottomLine.backgroundColor = UIColor.systemGray2.cgColor
        billAmountTextField.borderStyle = .none
        billAmountTextField.layer.addSublayer(bottomLine)
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        billAmountTextField.textAlignment = NSTextAlignment.right
        tipAmountLabel.textAlignment = NSTextAlignment.right
        totalLabel.textAlignment = NSTextAlignment.right
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        let value = storage.double(forKey: keys.key1)
        if(value==0.0){
            storage.setValue(0.15, forKey: keys.key1)
            storage.setValue(0.18, forKey: keys.key2)
            storage.setValue(0.20, forKey: keys.key3)
        }
        updateTitle()
        let bill4 = storage.double(forKey: keys.key4)
        if(bill4==0.0){
    	        storage.setValue(0, forKey: keys.key4)
        }
        let textValue = storage.string(forKey: keys.key4)
        billAmountTextField.text = textValue
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key1)*100) + "%", forSegmentAt: 0)
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key2)*100) + "%", forSegmentAt: 1)
        tipControl.setTitle(String(format: "%.0f",storage.double(forKey: keys.key3)*100) + "%", forSegmentAt: 2)
        calculateTip(animated)
        let isDarkMode = storage.bool(forKey: ViewController.keys.key5)
        if isDarkMode{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }else{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    
    @IBAction func storeNum(_ billAmountTextField: UITextField) {
        let bill = Double(billAmountTextField.text!) ?? 0
        storage.setValue(bill, forKey: keys.key4)
    }
    func updatePerPersonMoney(total:Double){
        perPersonMoney.text=String(format:"%.2f",total/storage.double(forKey: keys.key6))
    }
}

