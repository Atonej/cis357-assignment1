//
//  SettingsViewController.swift
//  conversionCalc
//
//  Created by CIS Student on 9/23/18.
//  Copyright © 2018 Atone-Anthony. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func indicateSelection(vice: String)
}
class SettingsViewController: UIViewController {
    var mode : CalculatorMode?

    var pickerData : [String] = [String]()
    var selection : String = "Yards"
    var delegate : SettingsViewControllerDelegate?
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissPicker))
        self.view.addGestureRecognizer(detectTouch)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMainView" {
            if let destVC = segue.destination.childViewControllers[0] as? ViewController {
                    mode = destVC.unit
            }
        }
    }
    
    @IBAction func fromBevel(_ sender: UIButton) {
        
        if mode == .Length {
            self.pickerData = ["Yards", "Meters", "Miles"]

        }
        
        else {
            self.pickerData = ["Gallons", "Liters", "Quarts"]

        }
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    @IBAction func toBevel(_ sender: UIButton) {
        if mode == .Length {
            self.pickerData = ["Yards", "Meters", "Miles"]
            
        }
            
        else {
            self.pickerData = ["Gallons", "Liters", "Quarts"]
            
        }
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    
    @objc func dismissPicker(){
        self.view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate {
            d.indicateSelection(vice: selection)
        }
    }
    @IBAction func cancelPressedButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressedButton(_ sender: UIBarButtonItem) {
        viewWillDisappear(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//learned from delegate video
extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selection = self.pickerData[row]
    }
}
