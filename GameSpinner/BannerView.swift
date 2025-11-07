//
//  BannerView.swift
//  Sourdough Buddy
//
//  Created by Steve Rose on 11/6/25.
//  Copyright © 2025 Steve Rose. All rights reserved.
//

#if !targetEnvironment(macCatalyst)

import SwiftUI
import GoogleMobileAds
import os

struct BannerAdView: UIViewRepresentable {
        
    // TODO: Make this configurable and change it to a real one before deployment
    let adUnitID: String = "ca-app-pub-3940256099942544/2934735716"
    
    let width: CGFloat
    
    func makeUIView(context: Context) -> BannerView {
        let adSize = currentOrientationAnchoredAdaptiveBanner(width: width)
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = adUnitID
        banner.delegate = context.coordinator
        banner.rootViewController = UIApplication.shared.firstKeyWindowRootViewcontroller()
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {
        let newSize = currentOrientationAnchoredAdaptiveBanner(width: width)
        if !CGSizeEqualToSize(newSize.size, uiView.adSize.size) {
            uiView.adSize = newSize
            uiView.load(Request())
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, BannerViewDelegate {

        private let logger = Logger(subsystem: "com.sdsoftware.sourdoughbuddy", category: "Coordinator.BannerView")

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            logger.info("Banner Loaded")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: any Error) {
            logger.error("Failed to load banner: \(error.localizedDescription)")
        }
    }
}

private extension UIApplication {
    func firstKeyWindowRootViewcontroller() -> UIViewController? {
        connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .rootViewController
    }
}

private extension UIWindowScene {
    var keyWindow: UIWindow? {
        windows.first(where: { $0.isKeyWindow })
    }
}
#endif
