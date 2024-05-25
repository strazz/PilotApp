//
//  PilotLicense.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import Foundation

struct PilotLicenses: Codable {
    var pilotLicenses: [PilotLicense]
    
    enum CodingKeys: String, CodingKey {
        case pilotLicenses = "pilot-licenses"
    }
}

struct PilotLicense: Codable {
    var type: LicenseType
    var aircrafts: [String]
}

enum LicenseType: String, Codable {
    case ppl = "PPL"
    case atpl = "ATPL"
    case mpl = "MPL"
}
