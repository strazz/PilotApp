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
        sut = ConfirmationViewModel(persistance: persistance)
        sut.navigationViewModel = navigationViewModel
    }

    override func tearDownWithError() throws {
        persistance = nil
        sut = nil
    }

    func testLogout() throws {
        sut.onLogout()
        XCTAssertTrue(persistance.removeValueCalled)
        XCTAssertEqual(Screen.registration, navigationViewModel.currentScreen)
    }

}
