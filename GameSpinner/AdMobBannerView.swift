//
//  AdMobBannerView.swift
//  GameSpinner
//
//  Created by Steve Rose on 11/7/25.
//  Copyright © 2025 Steve Rose. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import os

struct AdMobBannerView: UIViewRepresentable {
    
    private let logger = Logger(subsystem: "com.sdsoftware.sourdoughbuddy", category: "AdMobBannerView")

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> BannerView {
        // Get current screen width for adaptive size
        let adSize = currentOrientationAnchoredAdaptiveBanner(width: UIScreen.main.bounds.width)

        let bannerView = BannerView(adSize: adSize)

        if let adUnitID = Bundle.main.object(forInfoDictionaryKey: "GAD_UNIT_ID") as? String {
            bannerView.adUnitID = adUnitID
        } else {
            logger.error("⚠️ Missing GAD_UNIT_ID in Info.plist")
        }

        bannerView.delegate = context.coordinator
        bannerView.load(Request())

        // Find the top-most window scene
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            bannerView.rootViewController = rootVC
        }

        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Banner loaded successfully.")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Failed to load banner ad: \(error.localizedDescription)")
        }
    }
}
