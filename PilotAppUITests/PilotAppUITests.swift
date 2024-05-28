//
//  PilotAppUITests.swift
//  PilotAppUITests
//
//  Created by Giovanni Romaniello on 28/05/24.
//

import XCTest

final class PilotAppUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }

    func testCompleteFlow() throws {
        // UI tests must launch the application that they test.
        let nameField = app.textFields["Name"]
        XCTAssert(nameField.exists)
        nameField.tap()
        nameField.typeText("TestUser")
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123Abc123abc")
        let verificationField = app.secureTextFields["Password verification"]
        XCTAssert(verificationField.exists)
        verificationField.tap()
        verificationField.typeText("123Abc123abc")
        let licenseButton = app.buttons["PPL"]
        XCTAssert(licenseButton.exists)
        licenseButton.tap()
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssert(registerButton.isEnabled)
        registerButton.tap()
        XCTAssert(app.staticTexts["Confirmation"].exists)
        XCTAssert(app.staticTexts["Welcome TestUser!"].exists)
        XCTAssert(app.staticTexts["Your license is PPL"].exists)
        XCTAssert(app.staticTexts["C152"].exists)
        XCTAssert(app.staticTexts["C172"].exists)
        XCTAssert(app.staticTexts["D40A"].exists)
        
        let logoutButton = app.buttons["Logout"]
        XCTAssert(logoutButton.exists)
        XCTAssert(logoutButton.isEnabled)
        logoutButton.tap()
    }
    
    func testInvalidName() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        let nameField = app.textFields["Name"]
        XCTAssert(nameField.exists)
        nameField.tap()
        nameField.typeText("  ")
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssertFalse(registerButton.isEnabled)
        XCTAssert(app.staticTexts["Must contain at least one non-whitespace character."].exists)
    }
    
    func testEmptyPassword() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("")
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssertFalse(registerButton.isEnabled)
        XCTAssert(app.staticTexts["Password cannot be empty."].exists)
    }
    
    func testShortPassword() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123")
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssertFalse(registerButton.isEnabled)
        XCTAssert(app.staticTexts["Password must be at least 12 characters."].exists)
    }
    
    func testInvalidPassword() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123abc123abc")
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssertFalse(registerButton.isEnabled)
        XCTAssert(app.staticTexts["Password must be a combination of uppercase, lowercase and numbers."].exists)
    }
    
    func testVerificationPassword() {
        let app = XCUIApplication()
        app.launchArguments = ["UITest"]
        app.launch()
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123Abc123abc")
        let verificationField = app.secureTextFields["Password verification"]
        XCTAssert(verificationField.exists)
        verificationField.tap()
        verificationField.typeText("123Abc123abd")
        let registerButton = app.buttons["Register"]
        XCTAssert(registerButton.exists)
        XCTAssertFalse(registerButton.isEnabled)
        XCTAssert(app.staticTexts["Must be identical to the password."].exists)
    }

}
