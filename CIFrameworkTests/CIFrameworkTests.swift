//
//  CIFrameworkTests.swift
//  CIFrameworkTests
//
//  Created by Nicolas POINCET on 18/01/2018.
//  Copyright © 2018 Nicolas POINCET. All rights reserved.
//

import XCTest
@testable import CIFramework

class CIFrameworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDefaultLanguage() {
        
        
        let res = Language.getDefaultLanguage()
        
        XCTAssertEqual("en-US", res)
    }
    
    
    func testGetAllLanguage() {
        let testBundle = Bundle(for: type(of: self))
        let result = Language.getAllLanguages(testBundle)
        
        var res: Bool
        if (result.count >= 3) {
            res = true
        } else {
            res = false
        }
        
        XCTAssertTrue(res, "Test Error: One or more language is not present")
    }
    
    
    func testSetLanguage() {
        let lang = "fr"
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage(lang, bundle: testBundle)
        
        let res = Language.getCurrentLanguage()
        
        XCTAssertEqual(lang, res)
    }
    
    func testGetCurrentLanguage() {
        let lang = "fr"
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage(lang, bundle: testBundle)
        
        let res = Language.getCurrentLanguage()
        XCTAssertEqual("fr", res)
    }
    
    func testSetLanguageFail() {
        let lang = "fr"
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("it", bundle: testBundle)
        let res = Language.getCurrentLanguage()
        XCTAssertNotEqual(lang, res)
    }
    
    
    func testResetDefaultLanguage() {
        Language.resetCurrentLanguageToDefault()
        let res = Language.getCurrentLanguage()
        XCTAssertEqual("en-US", res)
    }
    
    
    func testdisplayNameForLanguage() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        let res = Language.displayNameForLanguage("fr")
        XCTAssertEqual("français", res)
    }
    
    
    func testdisplayNameForLanguage2() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        let res = Language.displayNameForLanguage("en-US")
        XCTAssertEqual("anglais (États-Unis)", res)
    }
    
    
    func testdisplayNameForLanguageDefaultIta() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("ita", bundle: testBundle)
        let res = Language.displayNameForLanguage("it")
        XCTAssertEqual("Italian", res)
    }
    
    
    func testdisplayNameForLanguageDefaultEnUS() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("en-US", bundle: testBundle)
        let res = Language.displayNameForLanguage("fr")
        XCTAssertEqual("French", res)
    }
    
    
    func testLocalisableFrench() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        let res1 = "Hello World".localized(using: "Localizable", in: testBundle)
        let res2 = "Change".localized(using: "Localizable", in: testBundle)
        let res3 = "Switch Language".localized(using: "Localizable", in: testBundle)
        
        
        XCTAssertEqual("Bonjour le monde", res1)
        XCTAssertEqual("Modifier", res2)
        XCTAssertEqual("Changer de langue", res3)
    }
    
    
    func testLocalisableItalian() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("it", bundle: testBundle)
        let res1 = "Hello World".localized(using: "Localizable", in: testBundle)
        let res2 = "Change".localized(using: "Localizable", in: testBundle)
        let res3 = "Switch Language".localized(using: "Localizable", in: testBundle)
        
        XCTAssertEqual("Ciao mondo", res1)
        XCTAssertEqual("Modifichi", res2)
        XCTAssertEqual("Passi il linguaggio", res3)
    }
    
    func testSetFlagToButton() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        
        
    }
}

