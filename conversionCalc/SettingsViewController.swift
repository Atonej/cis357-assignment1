//
//  SettingsViewController.swift
//  conversionCalc
//
//  Created by CIS Student on 9/23/18.
//  Copyright © 2018 Atone-Anthony. All rights reserved.
//

import UIKit
protocol SettingsViewControllerDelegate {
    func unitsSelection(from: String, to: String)
}
class SettingsViewController: UIViewController {
    var mode : CalculatorMode?
    
//    var fromPress : Bool
//    var toPress : Bool
    
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!

    var pickerData : [String] = [String]()
    var selection : String = "Yards"
    var selection2 : String = "Meters"
    var delegate : SettingsViewControllerDelegate?
    
    var whichLabel : Bool? //true is fromLabel, false is toLabel
    var save : Bool?
    
    @IBOutlet weak var picker: UIPickerView!
    override func viewDidLoad() {
        //self.setNeedsFocusUpdate()
        self.becomeFirstResponder()
        
        super.viewDidLoad()
        
        if mode == .Volume {
            selection = "Gallons"
            selection2 = "Liters"
            
            fromButton.setTitle("Gallons", for: UIControlState.normal)
            toButton.setTitle("Liters", for: UIControlState.normal)
        }
        
        self.reloadInputViews()
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissPicker))
        self.view.addGestureRecognizer(detectTouch)
        

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueMainView" {
//            if let destVC = segue.destination.childViewControllers[0] as? ViewController {
//                    destVC.currentMode()
//                    mode = destVC.unit
//            }
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
//        if segue.identifier == "segueMainView" {
//             let destVC = (segue.destination as! ViewController )
//                mode = destVC.unit
//
//        }
//    }
    @IBAction func fromBevel(_ sender: UIButton) {
        self.picker.isHidden = false
        whichLabel = true
        if mode! == .Length {
            self.pickerData = ["Yards", "Meters", "Miles"]

        }
        
        else {
            self.pickerData = ["Gallons", "Liters", "Quarts"]

        }
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }
    @IBAction func toBevel(_ sender: UIButton) {
        self.picker.isHidden = false
        whichLabel = false

        if mode! == .Length {
            self.pickerData = ["Yards", "Meters", "Miles"]
            
        }
            
        else {
            self.pickerData = ["Gallons", "Liters", "Quarts"]
            
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    
    @objc func dismissPicker(){
        //self.view.endEditing(true)
        self.picker.isHidden = true
        //self.picker2.isHidden = true

        
        fromButton.setTitle(self.selection, for: UIControlState.normal)
        toButton.setTitle(self.selection2, for: UIControlState.normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(self.save!){
            print("I am in saving")
            if let d = self.delegate {
            print("from: \(self.selection) to: \(self.selection2)")
            d.unitsSelection(from: self.selection, to: self.selection2)
        
        }
        }
        
        else {
            print ("not saving")
        }
    }
    @IBAction func cancelPressedButton(_ sender: UIBarButtonItem) {
        self.save = false
        //viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressedButton(_ sender: UIBarButtonItem) {
        self.save = true
        self.viewWillDisappear(true)
        self.dismiss(animated: true, completion: nil)
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
        if whichLabel == true {
        self.selection = self.pickerData[row]
        }
        else {
        self.selection2 = self.pickerData[row]
        }
    }
}
