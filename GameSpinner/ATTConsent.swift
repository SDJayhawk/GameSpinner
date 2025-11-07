//
//  ATTConsent.swift
//  Sourdough Buddy
//
//  Created by Steve Rose on 11/6/25.
//  Copyright © 2025 Steve Rose. All rights reserved.
//

import Foundation
import AppTrackingTransparency
import AdSupport

enum ATTAuthorization {
    static func requestIfNeeded() {
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization() { _ in
                
            }
        }
    }
}
