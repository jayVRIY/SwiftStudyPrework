//
//  SettinsViewController.swift
//  Prework
//
//  Created by Jay on 2022/7/21.
//

import UIKit

class SettinsViewController: UIViewController {

    let storage = UserDefaults.standard
    
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var num1: UITextField!
    @IBOutlet weak var num2: UITextField!
    @IBOutlet weak var num3: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        num1.text = String(format: "%.2f",storage.double(forKey: ViewController.keys.key1)*100) + "%"
        num2.text = String(format: "%.2f",storage.double(forKey: ViewController.keys.key2)*100) + "%"
        num3.text = String(format: "%.2f",storage.double(forKey: ViewController.keys.key3)*100) + "%"
        num1.returnKeyType = UIReturnKeyType.done
        num2.returnKeyType = UIReturnKeyType.done
        num3.returnKeyType = UIReturnKeyType.done
        switchButton.setOn(storage.bool(forKey: ViewController.keys.key5), animated: true)
        // Do any additional setup after loading the view.
    }
    @IBAction func upDateNum1(_ num1: UITextField) {
        let num1Text = num1.text
        let characterSet = CharacterSet(charactersIn: "%")
        let num1Str = num1Text!.trimmingCharacters(in: characterSet)
        let num1Value = (num1Str as NSString).doubleValue/100
        storage.setValue(num1Value, forKey: ViewController.keys.key1)
    }
    @IBAction func upDateNum2(_ num2: UITextField) {
        let num2Text = num2.text
        let characterSet = CharacterSet(charactersIn: "%")
        let num2Str = num2Text!.trimmingCharacters(in: characterSet)
        let num2Value = (num2Str as NSString).doubleValue/100
        storage.setValue(num2Value, forKey: ViewController.keys.key2)
    }
    @IBAction func upDateNum3(_ num3: UITextField) {
        let num3Text = num3.text
        let characterSet = CharacterSet(charactersIn: "%")
        let num3Str = num3Text!.trimmingCharacters(in: characterSet)
        let num3Value = (num3Str as NSString).doubleValue/100
        storage.setValue(num3Value, forKey: ViewController.keys.key3)
    }
    @IBAction func SwitchMode(_ switchButton: UISwitch) {
        if switchButton.isOn{
            storage.setValue(true, forKey: ViewController.keys.key5)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
        else{
            storage.setValue(false, forKey: ViewController.keys.key5)
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
