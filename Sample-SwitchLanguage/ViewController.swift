//
//  ViewController.swift
//  Sample-SwitchLanguage
//
//  Created by Nam Nguyen on 03/02/2018.
//  Copyright © 2018 Nicolas POINCET. All rights reserved.
//
import CIFramework
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mailEditTxt: UITextField!
    @IBOutlet weak var passEditTxt: UITextField!
    @IBOutlet weak var buttonConnect: UIButton!
    @IBOutlet weak var buttonExit: UIButton!
    @IBOutlet weak var buttonInfo: UIButton!
    
    let allLanguage = Language.getAllLanguages()
    
    var actionSheet: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designApp()
        
        Language.setCurrentLanguage("en-US")
        Language.delegate = self
        
        self.setText()
    }
    
    func designApp() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.gray.cgColor
        border.frame = CGRect(x: 0, y: mailEditTxt.frame.size.height - width, width:  mailEditTxt.frame.size.width, height: mailEditTxt.frame.size.height)
        
        border.borderWidth = width
        mailEditTxt.layer.addSublayer(border)
        mailEditTxt.layer.masksToBounds = true
        
        let borderPwd = CALayer()
        let widthPwd = CGFloat(2.0)
        borderPwd.borderColor = UIColor.gray.cgColor
        borderPwd.frame = CGRect(x: 0, y: passEditTxt.frame.size.height - widthPwd, width:  passEditTxt.frame.size.width, height: passEditTxt.frame.size.height)
        
        borderPwd.borderWidth = widthPwd
        passEditTxt.layer.addSublayer(borderPwd)
        passEditTxt.layer.masksToBounds = true
    }
    
    @objc func setText() {
        titleLabel.text = "Connection".localized(using: "Localizable")
        mailEditTxt.placeholder = "Email".localized(using: "Localizable")
        passEditTxt.placeholder = "Password".localized(using: "Localizable")
        
        buttonConnect.setTitle("Submit".localized(using: "Localizable"), for: .normal)
        buttonExit.setTitle("Reset".localized(using: "Localizable"), for: .normal)
        
        Language.setFlagToButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    // Remove the LCLLanguageChangeNotification on viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func doChangeLanguage(_ sender: AnyObject) {
        actionSheet = Language.flagAlert(allLanguage)
        //actionSheet = Language.basicAlert(allLanguage)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func resetLanguageToDeviceLanguage(_ sender: Any) {
        Language.resetCurrentLanguageToDefault()
    }
    
    
}

extension ViewController : LanguageDelegate {
    
    func language(_ language: Language.Type, getLanguageFlag flag: UIImage) {
        buttonInfo.setImage(flag.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
    }
}

