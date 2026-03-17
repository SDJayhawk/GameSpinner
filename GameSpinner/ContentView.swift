//
//  ContentView.swift
//  GameSpinner
//
//  Created by Steve Rose on 8/18/25.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @Environment(\.requestReview) private var requestReview

    @State var spinController: SpinController
    @State private var availableWidth: CGFloat = 320
    @State private var reviewController = ReviewController()
    
    init() {
        self.spinController = SpinController()
    }
    
    var body: some View {
        VStack(spacing: 0) {
#if !targetEnvironment(macCatalyst)
        AdMobBannerView()
            .frame(height: 50)
            .background(Color(uiColor: .systemBackground))
#endif
            TabView {
                SpinnerBoardView(spinController: $spinController)
                .tabItem {
                    Label("Spinner", systemImage: "arrow.trianglehead.2.counterclockwise.rotate.90")
                }
                HistoryView(spinController: $spinController)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                NavigationStack {
                    AboutView()
                }
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
            }

        }
        .onChange(of: reviewController.triggerReviewPrompt) {
            reviewController.displayReviewPrompt(
                { spinController.history.getItems().count > 10 }
            ) { requestReview() }
        }
        .environment(reviewController)
    }
}

#Preview {
    ContentView()
}
