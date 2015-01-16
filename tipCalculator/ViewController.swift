//
//  ViewController.swift
//  tipCalculator
//
//  Created by Xiaolong Zhang on 1/13/15.
//  Copyright (c) 2015 Xiaolong Zhang. All rights reserved.
//

import UIKit
var timeAtEnterBackground = NSDate().timeIntervalSince1970
var tipPercentages:[Double] = [15, 20, 25]
class ViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackgroundNotification", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        for i in 0...2 {
            tipControl.setTitle(String(format: "%.2f%%", tipPercentages[i]), forSegmentAtIndex: i)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func onEditing(sender: AnyObject) {
        var tipPercentage : Double = tipPercentages[tipControl.selectedSegmentIndex]
        var userEnteredValue = (amountTextField.text as NSString).doubleValue
        var tmpTipAmount = userEnteredValue*tipPercentage/100
        var tmpTotalAmount = userEnteredValue+tmpTipAmount
        tipAmount.text = currencyFormatter.stringFromNumber(tmpTipAmount)
        totalAmount.text = currencyFormatter.stringFromNumber(tmpTotalAmount)
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    func willEnterForegroundNotification(){
        var timeAtEnterForground = NSDate().timeIntervalSince1970
        if ((timeAtEnterForground-timeAtEnterBackground)>600){
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "amount")
            NSUserDefaults.standardUserDefaults().synchronize()
            amountTextField.text = NSUserDefaults.standardUserDefaults().objectForKey("amount") as? String
        }
    }
    
    func didEnterBackgroundNotification(){
        timeAtEnterBackground = NSDate().timeIntervalSince1970
        NSUserDefaults.standardUserDefaults().setObject(amountTextField.text, forKey: "amount")
        NSUserDefaults.standardUserDefaults().synchronize()
        let amount: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("amount")
        println("\(amount)")
    }
}

