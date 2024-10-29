//
//  calculatorUITests.swift
//  calculatorUITests
//
//  Created by Nassor, Hamad on 04/10/2024.
//

import XCTest

final class calculatorUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testAddition() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "7")
    }
    
    func testSubtraction() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["5"].tap()
        app.buttons["-"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "3")
    }
    
    func testMultiplication() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["2"].tap()
        app.buttons["X"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        
        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "10")
    }
    
    func testAdditionWithIncompleteExpression() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        
        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "7")
    }
    
    func testClear() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["2"].tap()
        app.buttons["AC"].tap()
        
        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "0")
    }
    
    func testErr() {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        app.buttons["9"].tap()

        let displayValue = app.otherElements["display"].label
            
        XCTAssertEqual(displayValue, "err")
    }
}
