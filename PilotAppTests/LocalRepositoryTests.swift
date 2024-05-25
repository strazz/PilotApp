//
//  LocalRepositoryTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import XCTest
@testable import PilotApp

final class LocalRepositoryTests: XCTestCase {
    
    private var sut: LocalLicensesRepository!

    override func setUpWithError() throws {
        sut = LocalLicensesRepository()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoadLicenses() async throws {
        let result = try await sut.getLicenses()
        XCTAssertEqual(3, result.count)
    }

}
