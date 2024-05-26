//
//  PilotAppApp.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

@main
struct PilotAppApp: App {
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("UITest") {
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            PilotAppViewFactory.buildContentView()
        }
    }
}
