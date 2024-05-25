//
//  LicensesRepository.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

protocol LicensesRepository {
    func getLicenses() async throws -> [PilotLicense]
}

class LocalLicensesRepository: LicensesRepository {
    func getLicenses() async throws -> [PilotLicense] {
        guard let url = Bundle.main.url(forResource: "licenses", withExtension: "json") else {
            throw RepositoryError.urlNotFound
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let json = try decoder.decode(PilotLicenses.self, from: data)
        return json.pilotLicenses
    }
}
