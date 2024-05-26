//
//  ViewExtensions.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 26/05/24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func buildErrorView(error: Error) -> some View {
        Text(error.localizedDescription)
            .foregroundStyle(.red)
            .fontWeight(.light)
            .font(.caption)
    }
}
