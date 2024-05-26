//
//  TestMocks.swift
//  PilotAppTests
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation
@testable import PilotApp

class TestRegistrationBusinessLogic: RegistrationBusinessLogic {
    
    var isSaveUserCalled = false
    override func saveUser(username: String, license: PilotLicense) throws -> User {
        isSaveUserCalled = true
        return User(name: "testUser", license: PilotLicense(type: .ppl, aircrafts: []))
    }
}

class MockLicensesRepository: LicensesRepository {
    func getLicenses() async throws -> [PilotApp.PilotLicense] {
        [
            PilotLicense(type: .ppl,
                         aircrafts: ["C152",
                                     "C172",
                                     "D40A"]),
            PilotLicense(type: .atpl,
                         aircrafts: ["B737",
                                     "A380",
                                     "B747"]),
            PilotLicense(type: .mpl,
                         aircrafts: ["A321",
                                     "A300",
                                     "B717"])
        ]
    }
}

class MockPersistable: Persistable {
    var saveValueCalled = false
    func saveValue<T: Encodable>(value: T, for key: String) throws {
        saveValueCalled = true
    }
    
    var getValueCalled = false
    func getValue<T: Decodable>(for key: String) throws -> T? {
        getValueCalled = true
        return nil
    }
    
    var removeValueCalled = false
    func removeValue(for key: String) {
        removeValueCalled = true
    }
}

extension MockPersistable: UserPersistance {
    func saveUser(user: PilotApp.User) throws {
        try saveValue(value: user, for: "user")
    }
    
    func getUser() throws -> PilotApp.User {
        User(name: "testUser",
             license: PilotLicense(type: .ppl,
                                   aircrafts: [
                                    "C152",
                                    "C172",
                                    "D40A"]))
    }
    
    func deleteUser() {
        removeValue(for: "user")
    }
}
