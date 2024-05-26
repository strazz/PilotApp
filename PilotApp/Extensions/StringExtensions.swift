//
//  StringExtensions.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
