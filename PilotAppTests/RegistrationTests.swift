//
//  PilotAppTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import XCTest
@testable import PilotApp

final class RegistrationTests: XCTestCase {
    
    private var sut: RegistrationViewModel!

    override func setUpWithError() throws {
        sut = RegistrationViewModel(
            businessLogic: RegistrationBusinessLogic()
        )
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    ///*
    //MARK: Name - Must contain at least one non-whitespace character.
    func testValidName() throws {
        sut.name = "Giovanni"
        XCTAssertTrue(sut.isNameValid)
    }
    
    func testEmptyName() throws {
        sut.name = ""
        XCTAssertFalse(sut.isNameValid)
    }
    
    func testWhitespacesName() throws {
        sut.name = "   "
        XCTAssertFalse(sut.isNameValid)
    }
    
    ///*
    //MARK: Pilot license type – A valid type of pilot license should be inserted.
    func testValidLicenceType() throws {
        sut.selectedLicence = "PPL"
        XCTAssertTrue(sut.isLicenceValid)
    }
    
    func testInvalidLicenceType() throws {
        sut.selectedLicence = "XXX"
        XCTAssertFalse(sut.isLicenceValid)
    }
    ///*
    //MARK: Password – Must be at least 12 characters, a combination of uppercase, lowercase and numbers and it’s not allowed to have the username in there.
    func testValidPassword() throws {
        sut.password = "A9sDk3fJ1lM2"
        XCTAssertTrue(sut.isPasswordValid)
    }
    
    func testEmptyPassword() throws {
        sut.password = ""
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testFewCharactersPassword() throws {
        sut.password = "A9sDk3fJ1lM"
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testUppercasedPassword() throws {
        sut.password = "A9SDK3FJ1LM2"
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testLowercasedPassword() throws {
        sut.password = "a9sdk3fj1lm2"
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testNoNumbersPassword() throws {
        sut.password = "asdkfjlMXxxx"
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testNoLettersPassword() throws {
        sut.password = "123456789012"
        XCTAssertFalse(sut.isPasswordValid)
    }
    
    func testNoUsernamePassword() throws {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2Giovanni"
        XCTAssertFalse(sut.isPasswordValid)
    }

    ///*
    //MARK: Password verification – Must be identical to the password.
    func testPasswordVerificationValidation() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM2"
        XCTAssertTrue(sut.isVerificationPasswordValid)
    }
    
    func testPasswordVerificationValidationError() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM"
        XCTAssertFalse(sut.isVerificationPasswordValid)
    }
    
    ///*
    //MARK: Register button must be enabled only if all validations succeeds
    func testRegisterButtonEnabled() {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM2"
        sut.selectedLicence = "PPL"
        XCTAssertTrue(sut.isRegisterButtonEnabled)
    }
    
    func testRegisterButtonDisabled() {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM"
        sut.selectedLicence = "PPL"
        XCTAssertFalse(sut.isRegisterButtonEnabled)
    }
}
