//
//  ClockUITests.swift
//  ClockUITests
//
//  Created by Wiktor Wójcik on 29/11/2020.
//

import XCTest

class ClockUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    func testStopwatch() throws {
        let app = XCUIApplication()
        app.launch()
    
        let label = app.staticTexts["0:00,00"]
        print(label.title)
        var button = app.buttons["Start"]
        button.tap()
        button = app.buttons["Stop"]
        sleep(1)
        button.tap()
        
        XCTAssertEqual(label.title, "0:01,00")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
