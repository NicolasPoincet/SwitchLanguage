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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        XCTAssertEqual("HELLO".localized(using: "Localized", in: testBundle), "Bonjour")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSetLanguageFr() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("fr", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "fr")
    }
    
    func testSetLanguageEn() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("en", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "en")
    }
    
    func testSetLanguageIt() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("it", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "it")
    }
    
    func testSetLanguageDe() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("de", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "de")
    }
    
    func testSetLanguageRu() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("ru", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "ru")
    }
    
    func testSetLanguageEs() {
        let testBundle = Bundle(for: type(of: self))
        Language.setCurrentLanguage("es", bundle: testBundle)
        XCTAssertEqual(Language.getCurrentLanguage(), "es")
    }
}
