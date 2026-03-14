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
        let bannerView = BannerView(adSize: currentOrientationAnchoredAdaptiveBanner(width: UIScreen.main.bounds.width))

        if let adUnitID = Bundle.main.object(forInfoDictionaryKey: "GAD_UNIT_ID") as? String {
            bannerView.adUnitID = adUnitID
        } else {
            logger.error("⚠️ Missing GAD_UNIT_ID in Info.plist")
        }

        bannerView.delegate = context.coordinator

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            bannerView.rootViewController = rootVC
        }

        context.coordinator.loadIfNeeded(bannerView, width: UIScreen.main.bounds.width)
        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {
        if uiView.rootViewController == nil,
           let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = scene.windows.first?.rootViewController {
            uiView.rootViewController = rootVC
        }

        context.coordinator.loadIfNeeded(uiView, width: uiView.bounds.width)
    }

    class Coordinator: NSObject, BannerViewDelegate {
        private var lastWidth: CGFloat = 0

        func loadIfNeeded(_ bannerView: BannerView, width: CGFloat) {
            let clampedWidth = max(0, width)
            guard clampedWidth > 0, abs(clampedWidth - lastWidth) > 1 else { return }
            lastWidth = clampedWidth
            bannerView.adSize = currentOrientationAnchoredAdaptiveBanner(width: clampedWidth)
            bannerView.load(Request())
        }

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Banner loaded successfully.")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Failed to load banner ad: \(error.localizedDescription)")
        }
    }
}
