//
//  RegistrationBusinessLogicTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import XCTest
@testable import PilotApp

final class RegistrationBusinessLogicTests: XCTestCase {
    
    private var sut: RegistrationBusinessLogic!

    override func setUpWithError() throws {
        sut = RegistrationBusinessLogic(repository: MockLicensesRepository(), 
                                        persistance: MockPersistable())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadLicenses() async throws {
        try await sut.loadLicenses()
        XCTAssertEqual(3, sut.licenses.count)
    }

    func testSaveUser() throws {
        let result = try sut.saveUser(username: "TestUser", license: PilotLicense(type: .ppl, aircrafts: []))
        XCTAssertTrue((sut.persistance as? MockPersistable)?.saveValueCalled == true)
        XCTAssertEqual(result.name, "TestUser")
    }
}
