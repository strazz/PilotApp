//
//  UserDefaultsPersistance.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

class UserDefaultsPersistance: Persistable {
    private let instance: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(name: String?) {
        self.instance = UserDefaults(suiteName: name) ?? UserDefaults.standard
    }

    func saveValue<T: Encodable>(value: T, for key: String) throws {
        let encoded = try encoder.encode(value)
        instance.setValue(encoded, forKey: key)
    }

    func getValue<T: Decodable>(for key: String) throws -> T? {
        guard let savedValue = instance.object(forKey: key) as? Data else {
            return nil
        }
        return try decoder.decode(T.self, from: savedValue)
    }
}
