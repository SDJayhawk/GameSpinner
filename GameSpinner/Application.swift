//
//  Application.swift
//  GameSpinner
//
//  Created by Steve Rose on 8/18/25.
//

import SwiftUI
import GoogleMobileAds

@main
struct Application: App {
    
    init() {
        // Initialize Google Mobile Ads SDK
        MobileAds.shared.start(completionHandler: nil)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
