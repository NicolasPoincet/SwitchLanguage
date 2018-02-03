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
let LCLCurrentTableNameKey = "LCLCurrentTableNameKey"
let LCLDefaultTableName = "Localizable"
public let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"

public extension String {
    
    /**
     It search the localized string
     
     @return The localized string.
     */
    public func localized() -> String {
        return localized(using: Language.getTableName())
    }
    
    /**
     It search the localized string
     
     @param tableName: The receiver’s string table to search.
     
     @param bundle: The receiver’s bundle to search.
     
     @return The localized string.
     */
    public func localized(using tableName: String, in bundle: Bundle = .main) -> String {
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
    
    /**
     Get the table name
     
     @return The current table name
     **/
    public class func getTableName() -> String {
        if let currentTableName = UserDefaults.standard.object(forKey: LCLCurrentTableNameKey) as? String {
            return currentTableName
        }
        return LCLDefaultTableName
    }
    
    
    /**
     Set the table name
     
     @param The table nameto set
     **/
    public class func setTableName(_ name: String) {
        UserDefaults.standard.set(name, forKey: LCLCurrentTableNameKey)
        UserDefaults.standard.synchronize()
    }

    /**
     It get the list of all available languages in the app.
     
     @return Array of available languages.
     */
    public class func getAllLanguages() -> [String] {
        var listLanguages = Bundle.main.localizations
        
        if let indexOfBase = listLanguages.index(of: LCLBaseBundle) {
            listLanguages.remove(at: indexOfBase)
        }
        
        return listLanguages
    }
    
    /**
     It get the current language of the app.
     
     @return String of current language.
     */
    public class func getCurrentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return getDefaultLanguage()
    }
    
    /**
     It change the current language of the app.
     
     @param language String correspondant to desired language.
     */
    public class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = getAllLanguages().contains(language) ? language : getDefaultLanguage()
        if (selectedLanguage != getCurrentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        }
    }
    
    /**
     It get the default language of the app.
     
     @return String of app default language.
     */
    public class func getDefaultLanguage() -> String {
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
    
    /**
     It reset the language with the default language of the app.
     
     @return String array of available languages.
     */
    public class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.getDefaultLanguage())
    }
    
    /**
     It get the current language and display his name.
     
     @param language String correspondant to desired language.
     
     @return String name of the current languages.
     */
    public class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: getCurrentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
    
    /**
     It display a basic alert with each names of available languages of the app.
     
     @param [String] array of all available languages.
     
     @return UIAlertController alert action to change the language.
     */
    public class func basicAlert(_ languages: [String]) -> UIAlertController {
        
        let actionSheet = UIAlertController(title: nil, message: "Switch Language".localized(), preferredStyle: UIAlertControllerStyle.actionSheet)
        for lang in languages {
            let displayName = Language.displayNameForLanguage(lang)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Language.setCurrentLanguage(lang)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertActionStyle.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        return actionSheet
    }
    
    /**
     It display an alert with the flags of each available languages of the app.
     
     @param [String] array of all available languages.
     
     @return UIAlertController alert action to change the language.
     */
    public class func flagAlert(_ languages: [String]) -> UIAlertController {
        
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
    
    class func matchFlag(langue: String) -> String{
        switch langue {
            case "en": return "gb"
            case "fr": return "fr"
            case "it": return "it"
            case "de": return "de"
            case "ja": return "jp"
            case "zh-Hans": return "cn"
        default:
            return langue
        }
    }
    
}

extension Language {
    
    /**
     Request to get the flag image of the languages.
     
     @param URL of the awaited image
     */
    class func getDataFromUrl(url : URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in completion(data, response, error)
            }.resume()
    }
    
    /**
     Call the request to download the awaited image for languages.
     
     @param URL of the awaited image
     */
    class func downloadImage(url: URL,  completionHandler: @escaping (UIImage?) -> Void) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completionHandler(image)
            }
        }
    }
    
}
