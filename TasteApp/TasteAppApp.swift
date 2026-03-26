//
//  TasteAppApp.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

@main
struct TasteAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
