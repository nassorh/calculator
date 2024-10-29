//
//  readoutViewModelTest.swift
//  calculatorTests
//
//  Created by Nassor, Hamad on 23/10/2024.
//

import XCTest
import Combine
@testable import calculator

final class readoutViewModelTest: XCTestCase {
    var viewModel: ReadoutViewModel!
    var mockCalculatorModel: CalculatorModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockCalculatorModel = CalculatorModel()
        viewModel = ReadoutViewModel(calculatorModel: mockCalculatorModel)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockCalculatorModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testDidUpdateDisplay() throws {
        let expectedValue = 5678
        let expectedStringArray = ["5", "6", "7", "8"]
        
        let displayValueExpectation = expectation(description: "displayValue update")
        
        var receivedDisplayValue: [String] = []
        
        viewModel.$displayValue
            .dropFirst() // Drops the first init value
            .sink { value in // When the value is recived do X
                receivedDisplayValue = value
                displayValueExpectation.fulfill() // Unblocks the expectaition
            }
            .store(in: &cancellables)
        
        viewModel.didUpdateDisplay(displayedValue: expectedValue, error: false)
        
        wait(for: [displayValueExpectation], timeout: 1)
        
        XCTAssertEqual(receivedDisplayValue, expectedStringArray)
    }
}
