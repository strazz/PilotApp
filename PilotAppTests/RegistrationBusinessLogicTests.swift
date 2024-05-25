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
        sut = RegistrationBusinessLogic(repository: MockLicensesRepository())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadLicenses() async throws {
        try await sut.loadLicenses()
        XCTAssertEqual(3, sut.licenses.count)
    }

}
