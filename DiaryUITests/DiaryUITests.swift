//
//  DiaryUITests.swift
//  DiaryUITests
//
//  Created by Карим Садыков on 19.04.2023.
//

import XCTest

final class DiaryUITests: XCTestCase {
    
    func testAddTaskUserInput() throws {
        let app = XCUIApplication()
        app.launch()
        let nameField = app.textFields["inputName"]
        let descField = app.textViews["inputDescription"]
        let addButtonAtCalendar = app.buttons["addButton"]

        app.swipeLeft()
        app.swipeLeft()
        addButtonAtCalendar.tap()
        nameField.tap()
        nameField.typeText("Test task")
        descField.tap()
        descField.typeText("Test desc")
        app.tapCoordinate(at: CGPoint(x: app.frame.maxX - 30, y: app.frame.minY + 40))
        app.tapCoordinate(at: CGPoint(x: 20, y: 20))
        app.navigationBars.buttons.element(boundBy: 0).tap()

    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


extension XCUIApplication {
    func tapCoordinate(at point: CGPoint) {
        let normalized = coordinate(withNormalizedOffset: .zero)
        let offset = CGVector(dx: point.x, dy: point.y)
        let coordinate = normalized.withOffset(offset)
        coordinate.tap()
    }
}
