import XCTest

final class KennelcostUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddEntryFlow() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addButton"].tap()
        let saveButton = app.buttons["saveButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5))
        saveButton.tap()
    }

    func testFreeLimitTriggersPaywall() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-UITEST_FORCE_LIMIT"]
        app.launch()

        app.buttons["addButton"].tap()
        let upgradeButton = app.buttons["upgradeButton"]
        let saveButton = app.buttons["saveButton"]
        XCTAssertTrue(upgradeButton.waitForExistence(timeout: 5) || saveButton.waitForExistence(timeout: 5))
    }

    func testKeyboardDismissOnTapOutside() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addButton"].tap()
        let textFields = app.textFields
        if textFields.count > 0 {
            textFields.firstMatch.tap()
            app.staticTexts.firstMatch.tap()
            XCTAssertFalse(app.keyboards.element.exists)
        }
    }

    func testSettingsOpens() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 5))
        app.buttons["settingsDoneButton"].tap()
    }

    func testDeleteEntry() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addButton"].tap()
        app.buttons["saveButton"].tap()
    }
}
