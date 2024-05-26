//
//  PilotAppTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import XCTest
@testable import PilotApp

final class RegistrationViewModelTests: XCTestCase {
    
    private var sut: RegistrationViewModel!
    private var businessLogic: TestRegistrationBusinessLogic!
    private var navigationViewModel: NavigationViewModel!

    @MainActor override func setUpWithError() throws {
        navigationViewModel = NavigationViewModel(persistence: MockPersistable())
        businessLogic = TestRegistrationBusinessLogic(
            repository: MockLicensesRepository(),
            persistance: MockPersistable())
        sut = RegistrationViewModel(
            businessLogic: businessLogic
        )
        sut.navigationViewModel = navigationViewModel
    }

    override func tearDownWithError() throws {
        navigationViewModel = nil
        businessLogic = nil
        sut = nil
    }

    ///*
    //MARK: Name - Must contain at least one non-whitespace character.
    @MainActor func testValidName() throws {
        sut.name = "Giovanni"
        XCTAssertNil(sut.nameError)
    }
    
    @MainActor func testEmptyName() throws {
        sut.name = ""
        XCTAssertEqual(ValidationError.invalidName, sut.nameError as! ValidationError)
    }
    
    @MainActor func testWhitespacesName() throws {
        sut.name = "   "
        XCTAssertEqual(ValidationError.invalidName, sut.nameError as! ValidationError)
    }
    
    ///*
    //MARK: Pilot license type – A valid type of pilot license should be inserted.
    @MainActor func testValidLicenseType() async throws {
        await sut.loadData()
        sut.selectedLicense = PilotLicense(type: .ppl, aircrafts: [])
        XCTAssertNil(sut.licenseError)
    }
    
    @MainActor func testInvalidLicenseType() throws {
        sut.selectedLicense = nil
        XCTAssertEqual(ValidationError.invalidLicense, sut.licenseError as! ValidationError)
    }
    ///*
    //MARK: Password – Must be at least 12 characters, a combination of uppercase, lowercase and numbers and it’s not allowed to have the username in there.
    @MainActor func testValidPassword() throws {
        sut.password = "A9sDk3fJ1lM2"
        XCTAssertNil(sut.passwordError)
    }
    
    @MainActor func testEmptyPassword() throws {
        sut.password = ""
        XCTAssertEqual(ValidationError.emptyPassword, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testFewCharactersPassword() throws {
        sut.password = "A9sDk3fJ1lM"
        XCTAssertEqual(ValidationError.shortPassword, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testUppercasedPassword() throws {
        sut.password = "A9SDK3FJ1LM2"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testLowercasedPassword() throws {
        sut.password = "a9sdk3fj1lm2"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testNoNumbersPassword() throws {
        sut.password = "asdkfjlMXxxx"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testNoLettersPassword() throws {
        sut.password = "123456789012"
        XCTAssertEqual(ValidationError.passwordFormat, sut.passwordError as! ValidationError)
    }
    
    @MainActor func testNoUsernamePassword() throws {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2Giovanni"
        XCTAssertEqual(ValidationError.passwordContainsUsername, sut.passwordError as! ValidationError)
    }

    ///*
    //MARK: Password verification – Must be identical to the password.
    @MainActor func testPasswordVerificationValidation() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM2"
        XCTAssertNil(sut.verificationPasswordError)
    }
    
    @MainActor func testPasswordVerificationValidationError() throws {
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM"
        XCTAssertEqual(ValidationError.verificationPassword, sut.verificationPasswordError as! ValidationError)
    }
    
    ///*
    //MARK: Register button must be enabled only if all validations succeeds
    @MainActor func testRegisterButtonEnabled() async {
        await sut.loadData()
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM2"
        sut.selectedLicense = PilotLicense(type: .ppl, aircrafts: [])
        XCTAssertTrue(sut.isRegisterButtonEnabled)
    }
    
    @MainActor func testRegisterButtonDisabled() {
        sut.name = "Giovanni"
        sut.password = "A9sDk3fJ1lM2"
        sut.verificationPassword = "A9sDk3fJ1lM"
        sut.selectedLicense = PilotLicense(type: .ppl, aircrafts: [])
        XCTAssertFalse(sut.isRegisterButtonEnabled)
    }
    
    ///*
    //MARK: test the loading state of the viewModel
    @MainActor func testViewModelIsLoading() async {
        XCTAssertFalse(sut.isLoading)
        let expectation = XCTestExpectation(description: "loading")
        Task {
            await sut.loadData()
            expectation.fulfill()
        }
        await Task.yield()
        XCTAssertTrue(sut.isLoading)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertFalse(sut.isLoading)
    }
    
    //MARK: test licenses loading:
    @MainActor func testLicensesLoaded() async throws {
        await sut.loadData()
        XCTAssertEqual(3, sut.licenses.count)
    }
    
    //MARK: test save license called
    @MainActor func testOnRegister() async throws {
        await sut.loadData()
        sut.selectedLicense = businessLogic.licenses.first
        try sut.onRegister()
        XCTAssertTrue(businessLogic.isSaveUserCalled)
        switch navigationViewModel.currentScreen {
        case .confirmation(_):
            break
        default:
            XCTFail("expecting confirmation screen")
        }
    }
}
