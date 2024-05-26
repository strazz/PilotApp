//
//  ContentView.swift
//  PilotApp
//
//  Created by Giovanni Romaniello on 25/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PilotAppViewFactory.buildRegistrationView()
        }
    }
}

#Preview {
    ContentView()
}
