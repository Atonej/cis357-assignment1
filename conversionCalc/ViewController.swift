//
//  ViewController.swift
//  conversionCalc
//
//  Created by Workbook-05 on 9/17/18.
//  Copyright © 2018 Atone-Anthony. All rights reserved.
//

import UIKit


class ViewController: UIViewController, SettingsViewControllerDelegate {
    func indicateSelection(vice: String) {
        self.fromLabel!.text = vice
        self.fromField!.placeholder = prefix + fromLabel!.text!
        self.toLabel!.text = vice
        self.toField!.placeholder = prefix + toLabel!.text!
    }
    
    
    var ans = 0.0
    var cons : Double = 0
    var getL = LengthConversionKey.init(toUnits: .Meters, fromUnits: .Yards)
    
    var getV = VolumeConversionKey.init(toUnits: .Liters, fromUnits: .Gallons)
    
    var prefix = "Enter length in "
    var unit = CalculatorMode.Length
    var tolength = LengthUnit.Yards
    var fromlength = LengthUnit.Yards

    var tovolume = VolumeUnit.Gallons
    var fromvolume = VolumeUnit.Gallons

    
    @IBOutlet weak var toField: DecimalMinusTextField!
    @IBOutlet weak var fromField: DecimalMinusTextField!
    
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var lorv: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SettingsViewController {
            dest.delegate = self
        }
    }
    
    func currentMode(){
        switch fromLabel.text{
        case "Yards":
            fromlength = .Yards
        case "Meters":
            fromlength = .Meters
        case "Miles":
            fromlength = .Miles
        case "Gallons":
            fromvolume = .Gallons
        case "Liters":
            fromvolume = .Liters
        case "Quarts":
            fromvolume = .Quarts
        default:
            print("There is an error")
        }
        
        switch toLabel.text{
        case "Yards":
            tolength = .Yards
        case "Meters":
            tolength = .Meters
        case "Miles":
            tolength = .Miles
        case "Gallons":
            tovolume = .Gallons
        case "Liters":
            tovolume = .Liters
        case "Quarts":
            tovolume = .Quarts
            default:
            print("There is an error")
        }
        
        if (lorv.text?.contains("Length"))! {
            unit = .Length
        }
        
        else {
            unit = .Volume
        }
    }

    @IBAction func settingsModeButton(_ sender: UIButton) {
        currentMode()
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        toField!.text = ""
        //toField!.clearsOnBeginEditing = true
        fromField.text = ""
        //fromField!.clearsOnBeginEditing = true
    }
    @IBAction func modeButtonPressed(_ sender: UIButton) {
        //change depending on length or volume
        if unit == .Length {
            lorv.text = lorv.text?.replacingOccurrences(of: "Length", with: "Volume")
            
            fromLabel!.text = "Gallons"
            fromField!.placeholder = prefix + fromLabel!.text!
            //fromvolume = .Gallons
            
            toLabel!.text = "Liters"
            toField!.placeholder = prefix + toLabel!.text!
            //tovolume = .Liters
            
            unit = .Volume
        }
        
        else {
            lorv.text = lorv.text?.replacingOccurrences(of: "Volume", with: "Length")

            fromLabel!.text = "Yards"
            fromField!.placeholder = prefix + fromLabel!.text!
            //fromlength = .Meters

            toLabel.text = "Meters"
            toField!.placeholder = prefix + toLabel!.text!
            //tolength = .Yards

            unit = .Length
        }
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        //check the current mode setup
        currentMode()
        if !(fromField.text?.isEmpty)! && !(toField.text?.isEmpty)! {
             print("Error, cannot have both boxes filled")
             print("clear out one of the boxes, thank you!")
            }
        //check the mode and which field to calculate
        else if unit == CalculatorMode.Length && !((fromField.text?.isEmpty)!) {
            switch fromlength {
                case .Meters:
                    getL = LengthConversionKey.init(toUnits: tolength, fromUnits: fromlength)
                    cons = lengthConversionTable[getL]!
                
                    ans = cons * Double(fromField.text!)!
                
            case .Miles:
                getL = LengthConversionKey.init(toUnits: tolength, fromUnits: fromlength)
                cons = lengthConversionTable[getL]!
                
                ans = cons * Double(fromField.text!)!
            case .Yards:
                getL = LengthConversionKey.init(toUnits: tolength, fromUnits: fromlength)
                cons = lengthConversionTable[getL]!
                //print("The constant is \(cons)")
                //print("from says \(fromLabel.text)")
                ans = cons * Double(fromField.text!)!
            }
            
            toField.text = String(ans)
            
        }
            
        else if unit == CalculatorMode.Length && !((toField.text?.isEmpty)!){
            switch tolength {
            case .Meters:
                getL = LengthConversionKey.init(toUnits: fromlength, fromUnits: tolength)
                cons = lengthConversionTable[getL]!
                
                ans = cons * Double(toField.text!)!
                
            case .Miles:
                getL = LengthConversionKey.init(toUnits: fromlength, fromUnits: tolength)
                cons = lengthConversionTable[getL]!
                
                ans = cons * Double(toField.text!)!
            case .Yards:
                getL = LengthConversionKey.init(toUnits: fromlength, fromUnits: tolength)
                cons = lengthConversionTable[getL]!
                //print("The constant is \(cons)")
                //print("from says \(fromLabel.text)")
                ans = cons * Double(toField.text!)!
            }
            
            fromField.text = String(ans)
        }
            
        else if unit == CalculatorMode.Volume && !((fromField.text?.isEmpty)!) {
            switch fromvolume {
            case .Gallons:
                getV = VolumeConversionKey.init(toUnits: tovolume, fromUnits: fromvolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(fromField.text!)!
                
            case .Liters:
                getV = VolumeConversionKey.init(toUnits: tovolume, fromUnits: fromvolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(fromField.text!)!
            case .Quarts:
                getV = VolumeConversionKey.init(toUnits: tovolume, fromUnits: fromvolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(fromField.text!)!
            }
            
            toField.text = String(ans)
        }
        
        else if unit == CalculatorMode.Volume && !((toField.text?.isEmpty)!) {
            switch tovolume {
            case .Gallons:
                getV = VolumeConversionKey.init(toUnits: fromvolume, fromUnits: tovolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(toField.text!)!
                
            case .Liters:
                getV = VolumeConversionKey.init(toUnits: fromvolume, fromUnits: tovolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(toField.text!)!
            case .Quarts:
                getV = VolumeConversionKey.init(toUnits: fromvolume, fromUnits: tovolume)
                cons = volumeConversionTable[getV]!
                
                ans = cons * Double(toField.text!)!
            }
            
            fromField.text = String(ans)
        }
        
        else {
            print("Error")
        }
    }
}

