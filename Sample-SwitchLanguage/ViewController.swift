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
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var mailEditTxt: UITextField!
    @IBOutlet weak var passLabel: UILabel!
    @IBOutlet weak var passEditTxt: UITextField!
    @IBOutlet weak var buttonConnect: UIButton!
    @IBOutlet weak var buttonExit: UIButton!
    @IBOutlet weak var buttonInfo: UIButton!
    
    let allLanguage = Language.getAllLanguages()
    
    var actionSheet: UIAlertController!
    
    var imgButtonLang : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Language.setCurrentLanguage("en-US")
        
        Language.delegate = self
        
        print(allLanguage)
        self.setText()
    }
    
    @objc func setText() {
        titleLabel.text = "Connection".localized(using: "Localizable")
        mailLabel.text = "Email".localized(using: "Localizable")
        mailEditTxt.text = "Email".localized(using: "Localizable")
        passLabel.text = "Password".localized(using: "Localizable")
        passEditTxt.text = "Password".localized(using: "Localizable")
        
        buttonConnect.setTitle("Connect".localized(using: "Localizable"), for: .normal)
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

