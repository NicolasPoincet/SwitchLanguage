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
    
    func testGetAllLanguages(){
        
    }
    
    func testgetCurrentLanguage() {
        let currentLanguage = Language.getCurrentLanguage()
        XCTAssertEqual(currentLanguage, "en")
    }
    
}
