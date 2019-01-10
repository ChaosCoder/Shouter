//
//  ShoutTests.swift
//  ShoutTests
//
//  Created by Andreas Ganske on 2019-01-09.
//  Copyright © 2019 Andreas Ganske. All rights reserved.
//

import XCTest
@testable import Shouter

class ShouterTests: XCTestCase {

    func testNotify() {
        let shouter = Shouter()
        
        let object = MockClass()
        shouter.register(MockProtocol.self, observer: object)
        
        let expectation = self.expectation(description: "Notify closure should be called")
        shouter.notify(MockProtocol.self) { observer in
            observer.somethingDidHappen(value: "Executed")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRemove() {
        let shouter = Shouter()
        
        let expectation = self.expectation(description: "Notify closure must not be called")
        expectation.isInverted = true
        
        let object = MockClass()
        shouter.register(MockProtocol.self, observer: object)
        shouter.unregister(MockProtocol.self, observer: object)
        shouter.notify(MockProtocol.self) { observer in
            observer.somethingDidHappen(value: "Not executed")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRemoveWhileNotifying() {
        let shouter = Shouter()
        
        let expected = self.expectation(description: "Notify closure should be called")
        let notExpected = self.expectation(description: "Notify closure must not be called")
        notExpected.isInverted = true
        
        let object = MockClass()
        shouter.register(MockProtocol.self, observer: object)
        
        shouter.notify(MockProtocol.self) { observer in
            observer.somethingDidHappen(value: "Executed")
            expected.fulfill()
            shouter.unregister(MockProtocol.self, observer: object)
        }
        
        shouter.notify(MockProtocol.self) { observer in
            observer.somethingDidHappen(value: "Not executed")
            notExpected.fulfill()
        }
        
        wait(for: [expected, notExpected], timeout: 1.0)
    }
}

protocol MockProtocol {
    func somethingDidHappen(value: String)
}

class MockClass: MockProtocol {
    func somethingDidHappen(value: String) {
        print("Something did happen: \(value)")
    }
}

