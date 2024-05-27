//
//  FormValidatorTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 28/05/24.
//

import XCTest
@testable import PilotApp

final class FormValidatorTests: XCTestCase {
    
    private var sut: FormValidator!

    override func setUpWithError() throws {
        sut = FormValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    private func assertSuccess(result: Result<Void, Error>) {
        switch result {
        case .failure(_):
            XCTFail()
        default:
            break
        }
    }
    
    private func assertError(validationError: ValidationError, result: Result<Void, Error>) {
        switch result {
        case .failure(let error):
            XCTAssertEqual(validationError, error as! ValidationError)
        default:
            XCTFail()
        }
    }

    ///*
    //MARK: Name - Must contain at least one non-whitespace character.
    @MainActor func testValidName() throws {
        let result = sut.validateName(name: "TestUser")
        assertSuccess(result: result)
    }
    
    @MainActor func testEmptyName() throws {
        let result = sut.validateName(name: "")
        assertError(validationError: .invalidName, result: result)
    }
    
    @MainActor func testWhitespacesName() throws {
        let result = sut.validateName(name: "   ")
        assertError(validationError: .invalidName, result: result)
    }
    
    ///*
    //MARK: Pilot license type – A valid type of pilot license should be inserted.
    @MainActor func testValidLicenseType() async throws {
        let result = sut.validateLicense(PilotLicense(type: .ppl, aircrafts: []), in: [PilotLicense(type: .ppl, aircrafts: [])])
        assertSuccess(result: result)
    }
    
    @MainActor func testInvalidLicenseType() throws {
        let result = sut.validateLicense(PilotLicense(type: .ppl, aircrafts: []), in: [PilotLicense(type: .atpl, aircrafts: [])])
        assertError(validationError: ValidationError.invalidLicense, result: result)
    }
    ///*
    //MARK: Password – Must be at least 12 characters, a combination of uppercase, lowercase and numbers and it’s not allowed to have the username in there.
    @MainActor func testValidPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "A9sDk3fJ1lM2")
        assertSuccess(result: result)
    }
    
    @MainActor func testEmptyPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "")
        assertError(validationError: ValidationError.emptyPassword, result: result)
    }
    
    @MainActor func testFewCharactersPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "A9sDk3fJ1lM")
        assertError(validationError: ValidationError.shortPassword, result: result)
    }
    
    @MainActor func testUppercasedPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "A9SDK3FJ1LM2")
        assertError(validationError: ValidationError.passwordFormat, result: result)
    }
    
    @MainActor func testLowercasedPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "a9sdk3fj1lm2")
        assertError(validationError: ValidationError.passwordFormat, result: result)
    }
    
    @MainActor func testNoNumbersPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "asdkfjlMXxxx")
        assertError(validationError: ValidationError.passwordFormat, result: result)
    }
    
    @MainActor func testNoLettersPassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "123456789012")
        assertError(validationError: ValidationError.passwordFormat, result: result)
    }
    
    @MainActor func testNoUsernamePassword() throws {
        let result = sut.validatePassword(username: "testUser", password: "A9sDk3fJ1lM2TestUser")
        assertError(validationError: ValidationError.passwordContainsUsername, result: result)
    }
}
