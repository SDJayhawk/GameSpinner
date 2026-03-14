//
//  ReviewController.swift
//
//  Created by Steve Rose on 03/12/26.
//  Copyright © 2026 Steve Rose. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftData
import os

@Observable
class ReviewController {
    
    var triggerReviewPrompt = false
    
    private var isPresentingReviewRequest: Bool = false
    
    init() {
        if nextDateForReviewOptional == nil {
            nextDateForReviewOptional = initialReviewDate
        }
    }
    
    var lastVersionPromptedForReview: String = UserDefaults.standard.string(forKey: "lastVersionPromptedForReview") ?? "" {
        didSet {
            UserDefaults.standard.setValue(lastVersionPromptedForReview, forKey: "lastVersionPromptedForReview")
        }
    }
    
    private var nextDateForReviewOptional: Date? = UserDefaults.standard.object(forKey: "nextDateForReview") as? Date {
        didSet {
            UserDefaults.standard.setValue(nextDateForReview, forKey: "nextDateForReview")
        }
    }

    var nextDateForReview: Date {
        get {
            nextDateForReviewOptional ?? initialReviewDate
        }
        set {
            nextDateForReviewOptional = newValue
        }
    }

    private var initialReviewDate: Date {
        Calendar.current.date(byAdding: .day, value: 7, to: .now) ?? .now
    }

    func displayReviewPrompt(_ condition: () -> Bool, reviewAction: @escaping () -> Void) {
        if let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            triggerReviewPrompt &&
            !isPresentingReviewRequest &&
            currentAppVersion != lastVersionPromptedForReview &&
            .now > nextDateForReview &&
            condition() {
            isPresentingReviewRequest = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                reviewAction()
                self.lastVersionPromptedForReview = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                self.nextDateForReview = .now.addingTimeInterval(7*24*60*60)
                self.isPresentingReviewRequest = false
            }
        }
        triggerReviewPrompt = false
    }
}
