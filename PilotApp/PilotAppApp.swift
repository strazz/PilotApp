//
//  PilotAppApp.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

@main
struct PilotAppApp: App {
    var body: some Scene {
        WindowGroup {
            PilotAppViewFactory.buildContentView()
        }
    }
}
