//
//  Language.swift
//  Multilingue-Test
//
//  Created by Bérangère La Touche on 21/01/2018.
//  Copyright © 2018 Bérangère La Touche. All rights reserved.
//

import Foundation
import UIKit

let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"

let LCLDefaultLanguage = "en"

let LCLBaseBundle = "Base"

public let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"

public extension String {
    
    /**
     * Returns: The localized string.
     */
    func localized() -> String {
        return localized(using: nil, in: .main)
    }
    
    func localized(using tableName: String?) -> String {
        return localized(using: tableName, in: .main)
    }
    
    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: Language.getCurrentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        else if let path = bundle.path(forResource: LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }
}

public class Language : NSObject {
    
    class func getAllLanguages() -> [String] {
        var listLanguages = Bundle.main.localizations
        
        if let indexOfBase = listLanguages.index(of: LCLBaseBundle) {
            listLanguages.remove(at: indexOfBase)
        }
        
        return listLanguages
    }
    
    class func getCurrentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return getDefaultLanguage()
    }
    
    open class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = getAllLanguages().contains(language) ? language : getDefaultLanguage()
        if (selectedLanguage != getCurrentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        }
    }
    
    class func getDefaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = getAllLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.getDefaultLanguage())
    }
    
    
    class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: getCurrentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
    
    class func basicAlert(_ languages: [String]) -> UIAlertController {
        
        let actionSheet = UIAlertController(title: nil, message: "Switch Language".localized(), preferredStyle: UIAlertControllerStyle.actionSheet)
        for lang in languages {
            let displayName = Language.displayNameForLanguage(lang)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Language.setCurrentLanguage(lang)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        return actionSheet
    }
    
    class func flagAlert(_ languages: [String]) -> UIAlertController {
        
        let actionSheet = UIAlertController(title: nil, message: "Switch Language".localized(), preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let imageView = UIImageView()
        actionSheet.view.addSubview(imageView)
        
        for lang in languages {
            let flag = URL(string: "http://www.countryflags.io/\(lang)/flat/64.png")
            
            var cFlag = UIImage()
            downloadImage(url: flag!) { img in
                if (img?.cgImage != nil) {
                    cFlag = img!
                    let displayName = Language.displayNameForLanguage(lang)
                    let languageAction = UIAlertAction(title: displayName, style: .default, handler: { (alert: UIAlertAction!) -> Void  in
                        Language.setCurrentLanguage(lang)
                    })
                    languageAction.setValue(cFlag.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forKey: "image")
                    
                    actionSheet.addAction(languageAction)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        return actionSheet
    }
    
}

extension Language {
    
    class func getDataFromUrl(url : URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in completion(data, response, error)
            }.resume()
    }
    
    class func downloadImage(url: URL,  completionHandler: @escaping (UIImage?) -> Void) {
        print("URL:", url)
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completionHandler(image)
            }
        }
    }
    
}
