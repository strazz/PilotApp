//
//  Persistable.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

protocol Persistable {
    func saveValue<T: Encodable>(value: T, for key: String) throws
    func getValue<T: Decodable>(for key: String) throws -> T?
}
