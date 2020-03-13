//
//  ProductDiscoveryUITests.swift
//  ProductDiscoveryUITests
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import XCTest

class ProductDiscoveryUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        super.tearDown()
    }

    func testPlaceHolderSearchBarNormal() {
        // given
        let searchBar = app.textFields["searchBar"]

        // then
        XCTAssertEqual(searchBar.placeholderValue, "Nhập tên, mã sản phẩm")
    }

    func testPlaceHolderSearchBarAbnormal() {
        // given
        let searchBar = app.textFields["searchBar"]

        // then
        XCTAssertNotEqual(searchBar.placeholderValue, "Nhập tên sản phẩm")
    }
}
