//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by Xiaolong Zhang on 1/14/15.
//  Copyright (c) 2015 Xiaolong Zhang. All rights reserved.
//

import UIKit

var segmentedControlSelection = 0
class SettingsViewController: UIViewController {

    @IBOutlet weak var tipOne: UITextField!
    @IBOutlet weak var tipTwo: UITextField!
    @IBOutlet weak var tipThree: UITextField!

    @IBOutlet weak var sliderOne: UISlider!
    @IBOutlet weak var sliderTwo: UISlider!
    @IBOutlet weak var sliderThree: UISlider!
    
    @IBOutlet weak var selectedTheme: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedTheme.selectedSegmentIndex = segmentedControlSelection
        setThemeBase(segmentedControlSelection)
    }

    @IBAction func opTap(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstTipSlider(sender: AnyObject) {
        var currentValue = sliderOne.value
        tipOne.text = String(format: "%.2f", currentValue)
        setTipValue(tipOne.text, tipIndex: 0)
    }

    @IBAction func secondTipSlider(sender: AnyObject) {
        var currentValue = sliderTwo.value
        tipTwo.text = String(format: "%.2f", currentValue)
        setTipValue(tipTwo.text, tipIndex: 1)
    }

    @IBAction func thirdTipSlider(sender: AnyObject) {
        var currentValue = sliderThree.value
        tipThree.text = String(format: "%.2f", currentValue)
        setTipValue(tipThree.text, tipIndex: 2)
    }
    
    @IBAction func tipOneChanged(sender: AnyObject) {
        sliderOne.value = (tipOne.text as NSString).floatValue
        tipPercentages[0] = (tipOne.text as NSString).doubleValue
        setTipValue(tipOne.text, tipIndex: 0)
    }
    
    @IBAction func tipTwoChanged(sender: AnyObject) {
        sliderTwo.value = (tipTwo.text as NSString).floatValue
        setTipValue(tipTwo.text, tipIndex: 1)
    }
    
    @IBAction func tipThreeChanged(sender: AnyObject) {
        sliderThree.value = (tipThree.text as NSString).floatValue
        setTipValue(tipThree.text, tipIndex: 2)
    }
    
    func setTipValue(tipValue: String, tipIndex: Int){
        tipPercentages[tipIndex] = (tipValue as NSString).doubleValue
    }
    
    @IBAction func setTheme(sender: AnyObject) {
        setThemeBase(selectedTheme.selectedSegmentIndex)
    }
    
    func setThemeBase(themeIndex: Int){
        if(themeIndex == 0){
            self.navigationController?.navigationBar.barTintColor = nil
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
            self.view.backgroundColor = UIColor.whiteColor()
            segmentedControlSelection = 0
            for view in self.view.subviews as [UIView] {
                if let uiLabel = view as? UILabel {
                    uiLabel.textColor = UIColor.blackColor()
                } else if let uiTextField = view as? UITextField {
                    uiTextField.textColor = UIColor.blackColor()
                }
            }
        } else if(themeIndex == 1){
            self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
            UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.view.backgroundColor = UIColor.blackColor()
            segmentedControlSelection = 1
            for view in self.view.subviews as [UIView] {
                if let uiLabel = view as? UILabel {
                    uiLabel.textColor = UIColor.whiteColor()
                } else if let uiTextField = view as? UITextField {
                    uiTextField.textColor = UIColor.whiteColor()
                }
            }
        }
    }
}
