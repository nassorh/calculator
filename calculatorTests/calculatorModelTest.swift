//
//  calculatorTests.swift
//  calculatorTests
//
//  Created by Nassor, Hamad on 04/10/2024.
//

import XCTest
@testable import calculator

// TODO: used this https://stackoverflow.com/a/53994296, where should this be stored
class MockCalculatorDelegate: CalculatorModelDelegate {
    var didCallDidUpdateDisplay = false
    
    func didUpdateDisplay(displayedValue: Int, error: Bool) {
        didCallDidUpdateDisplay = true
    }
}

final class calculatorModelTest: XCTestCase {
    var calculator: CalculatorModel!
    var mockDelegate: MockCalculatorDelegate!
    
    override func setUpWithError() throws {
        super.setUp()
        calculator = CalculatorModel()
        mockDelegate = MockCalculatorDelegate()
        calculator.calculatorModelDelegate = mockDelegate
    }
    
    override func tearDown() {
        calculator = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    //TODO: Parameterised tests
    func testEnterNumberWhenCurrentValueIsZero() {
        calculator.displayedValue = Array(repeating: 0, count: 9)
        
        calculator.enterNumber(5)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,5])
        XCTAssertEqual(calculator.isError, false)
    }
    
    func testEnterNumberExceedingMaxDigits(){
        calculator.displayedValue = [9,9,9,9,9,9,9,9,9]
        calculator.maxNumberOfDigits = 9
        
        //TODO: how to make it clear that this is done since we want to prove that the previous value and current operation is being updated not just asserting the defaults
        calculator.storedValue = [0,0,0,0,0,0,0,0,-1]
        calculator.currentOperation = .addition
        
        calculator.enterNumber(9)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.storedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertTrue(calculator.isError)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
    }
    
    func testEnterNumberWhenCurrentValueIsNotZero() {
        calculator.displayedValue = [0,0,0,0,0,0,0,0,9]
        
        calculator.enterNumber(5)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,9,5])
        XCTAssertEqual(calculator.isError, false)
    }
    
    func testSetDisplayInputWhenCurrentValueIsZero() {
        calculator.setDisplayInput(number: 5)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,5])
        XCTAssertEqual(calculator.isError, false)
    }
    
    func testSetDisplayInputWhenCurrentValueIsNotZero() {
        calculator.displayedValue = [0,0,0,0,0,0,0,0,9]
        
        calculator.setDisplayInput(number: 5)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,5])
        XCTAssertEqual(calculator.isError, false)
    }
    
    func testSetDisplayInputWhenCurrentValueExceedsMaxDigits() {
        calculator.displayedValue = [0,0,0,0,0,0,0,0,-1]
        calculator.storedValue = [0,0,0,0,0,0,0,0,-1]
        calculator.currentOperation = .addition
        
        calculator.setDisplayInput(number: 9_999_999_999)
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.storedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertEqual(calculator.isError, true)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
    }
    
    func testSetOperationWhenOperationIsNotNoneWithValues(){
        calculator.storedValue = [0,0,0,0,0,0,0,1,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,2]
        calculator.currentOperation = .addition
        
        calculator.setOperation(operation: .subtraction)
        
        XCTAssertEqual(calculator.currentOperation, .subtraction)
        XCTAssertEqual(calculator.storedValue, [0,0,0,0,0,0,0,2,2])
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
    }
    
    func testSetOperationWhenOperationIsNone(){
        calculator.setOperation(operation: .subtraction)
        
        XCTAssertEqual(calculator.currentOperation, .subtraction)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
        
    }
    
    func testPerformEqualsWhenCurrentOperationIsMultiplication(){
        calculator.storedValue = [0,0,0,0,0,0,0,2,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,0]
        calculator.currentOperation = .multiplication
        
        calculator.performEquals()
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,2,0,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
        
    }
    
    func testPerformEqualsWhenCurrentOperationIsSubtraction(){
        calculator.storedValue = [0,0,0,0,0,0,0,2,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,0]
        calculator.currentOperation = .subtraction
        
        calculator.performEquals()
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,1,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
        
    }
    
    func testPerformEqualsWhenCurrentOperationIsAddition(){
        calculator.storedValue = [0,0,0,0,0,0,0,2,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,0]
        calculator.currentOperation = .addition
        
        calculator.performEquals()
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,3,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
        
    }
    
    func testPerformEqualsWhenCurrentOperationIsNone(){
        calculator.storedValue = [0,0,0,0,0,0,0,2,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,0]
        calculator.currentOperation = .none
        
        calculator.performEquals()
        
        XCTAssertEqual(calculator.storedValue, [0,0,0,0,0,0,0,2,0])
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,1,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        
    }
    
    func testClear(){
        calculator.storedValue = [0,0,0,0,0,0,0,2,0]
        calculator.displayedValue = [0,0,0,0,0,0,0,1,0]
        calculator.currentOperation = .addition
        calculator.isError = true
        
        calculator.clear()
        
        XCTAssertEqual(calculator.displayedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.storedValue, [0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(calculator.currentOperation, .none)
        XCTAssertEqual(calculator.isError, false)
        XCTAssertTrue(mockDelegate.didCallDidUpdateDisplay)
    }
}
