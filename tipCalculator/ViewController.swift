//
//  ViewController.swift
//  tipCalculator
//
//  Created by Xiaolong Zhang on 1/13/15.
//  Copyright (c) 2015 Xiaolong Zhang. All rights reserved.
//

import UIKit

// Shared variable
var timeAtEnterBackground = NSDate().timeIntervalSince1970
var tipPercentages:[Double] = [15, 20, 25]

class ViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var onePersonSplit: UILabel!
    @IBOutlet weak var twoPeopleSplit: UILabel!
    @IBOutlet weak var threePeopleSplit: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var dvImage: UIImageView!
    @IBOutlet weak var seperator: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "willEnterForegroundNotification", name: UIApplicationWillEnterForegroundNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didEnterBackgroundNotification", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        for i in 0...2 {
            tipControl.setTitle(String(format: "%.2f%%", tipPercentages[i]), forSegmentAtIndex: i)
        }
        onEditing(self)
        if segmentedControlSelection == 0 {
            self.view.backgroundColor = UIColor.whiteColor()
            for view in self.view.subviews as [UIView] {
                if let uiLabel = view as? UILabel {
                    uiLabel.textColor = UIColor.blackColor()
                } else if let uiTextField = view as? UITextField {
                    uiTextField.textColor = UIColor.blackColor()
                }
            }
            var image = UIImage(named: "darthVader")
            dvImage.image = image
            seperator.backgroundColor = UIColor.blackColor()
        } else if segmentedControlSelection == 1 {
            self.view.backgroundColor = UIColor.blackColor()
            for view in self.view.subviews as [UIView] {
                if let uiLabel = view as? UILabel {
                    uiLabel.textColor = UIColor.whiteColor()
                } else if let uiTextField = view as? UITextField {
                    uiTextField.textColor = UIColor.whiteColor()
                }
            }
            var image = UIImage(named: "invertedDarthVader")
            dvImage.image = image
            seperator.backgroundColor = UIColor.whiteColor()
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
        onePersonSplit.text = totalAmount.text
        twoPeopleSplit.text = currencyFormatter.stringFromNumber(tmpTotalAmount/2)
        threePeopleSplit.text = currencyFormatter.stringFromNumber(tmpTotalAmount/3)
    }
    
    var currencyFormatter: NSNumberFormatter {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter
    }
    
    func willEnterForegroundNotification(){
        var timeAtEnterForground = NSDate().timeIntervalSince1970
        if (timeAtEnterForground-timeAtEnterBackground)>6{
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
    }
}

