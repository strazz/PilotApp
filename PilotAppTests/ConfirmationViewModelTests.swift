//
//  ConfirmationViewModelTests.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import XCTest
@testable import PilotApp

final class ConfirmationViewModelTests: XCTestCase {
    private var sut: ConfirmationViewModel!
    private var navigationViewModel: NavigationViewModel!
    private var persistance: MockPersistable!

    override func setUpWithError() throws {
        persistance = MockPersistable()
        navigationViewModel = NavigationViewModel(persistence: MockPersistable())
        let user = try! persistance.getUser()
        sut = ConfirmationViewModel(user: user, persistance: persistance)
        sut.navigationViewModel = navigationViewModel
    }

    override func tearDownWithError() throws {
        persistance = nil
        sut = nil
    }

    func testLogout() throws {
        sut.onLogout()
        XCTAssertTrue(persistance.removeValueCalled)
        switch navigationViewModel.currentScreen {
        case .registration:
            break
        default:
            XCTFail("expecting registration screen")
        }
    }

    func testAllowedAircrafts() {
        XCTAssertEqual(3, sut.allowedAircrafts.count)
    }
    
    func testUsername() {
        XCTAssertEqual("testUser", sut.username)
    }
    
    func testLicenseType() {
        XCTAssertEqual(LicenseType.ppl.rawValue.uppercased(), sut.license)
    }
}
