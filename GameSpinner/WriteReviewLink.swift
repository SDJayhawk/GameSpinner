//
//  WriteReviewLink.swift
//  BusyBeeTimeTracker
//
//  Created by Steve Rose on 2/5/26.
//  Copyright © 2026 Steve Rose. All rights reserved.
//

import SwiftUI

struct WriteReviewLink: View {
    @Environment(\.openURL) private var openURL
    let appID = Bundle.main.object(forInfoDictionaryKey: "AppStoreIdentifier") as? String ?? ""

    var body: some View {
        Button("Write a Review on the App Store", action: requestReviewManually)
    }
    
    private func requestReviewManually() {
        // Replace the placeholder value below with the App Store ID for your app.
        // You can find the App Store ID in your app's product URL.
        let url = "https://apps.apple.com/app/id\(appID)?action=write-review"
        
        guard let writeReviewURL = URL(string: url) else {
            fatalError("Expected a valid URL")
        }
        
        openURL(writeReviewURL)
    }
}
