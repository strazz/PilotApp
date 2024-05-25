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
        XCTAssertNil(sut.nameError)
    }
    
    func testEmptyName() throws {
        sut.name = ""
        XCTAssertEqual(ValidationError.invalidName, sut.nameError as! ValidationError)
    }
    
    func testWhitespacesName() throws {
        sut.name = "   "
        XCTAssertEqual(ValidationError.invalidName, sut.nameError as! ValidationError)
    }
    
    ///*
    //MARK: Pilot license type – A valid type of pilot license should be inserted.
    func testValidLicenceType() throws {
        sut.selectedLicence = "PPL"
        XCTAssertNil(sut.licenceError)
    }
    
    func testInvalidLicenceType() throws {
        sut.selectedLicence = "XXX"
        XCTAssertEqual(ValidationError.invalidLicence, sut.licenceError as! ValidationError)
    }
    ///*
    //MARK: Password – Must be at least 12 characters, a combination of uppercase, lowercase and numbers and it’s not allowed to have the username in there.
    func testValidPassword() throws {
        sut.password = "A9sDk3fJ1lM2"
        XCTAssertNil(sut.passwordError)
    }
    
    func testEmptyPassword() throws {
        sut.password = ""
        XCTAssertEqual(ValidationError.emptyPassword, sut.passwordError as! ValidationError)
    }
    
    func testFewCharactersPassword() throws {
        sut.password = "A9sDk3fJ1lM"
        XCTAssertEqual(ValidationError.shortPassword, sut.passwordError as! ValidationError)
    }
    
    func testUppercasedPassword() throws {
        sut.password = "A9SDK3FJ1LM2"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    func testLowercasedPassword() throws {
        sut.password = "a9sdk3fj1lm2"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    func testNoNumbersPassword() throws {
        sut.password = "asdkfjlMXxxx"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    func testNoLettersPassword() throws {
        sut.password = "123456789012"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    func testNoUsernamePassword() throws {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2Giovanni"
        XCTAssertEqual(ValidationError.passwordContainsUsername, sut.passwordError as! ValidationError)
    }

    ///*
    //MARK: Password verification – Must be identical to the password.
    func testPasswordVerificationValidation() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM2"
        XCTAssertNil(sut.verificationPasswordError)
    }
    
    func testPasswordVerificationValidationError() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM"
        XCTAssertEqual(ValidationError.verificationPassword, sut.verificationPasswordError as! ValidationError)
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
