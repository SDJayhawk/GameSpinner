//
//  ContentView.swift
//  GameSpinner
//
//  Created by Steve Rose on 8/18/25.
//

import SwiftUI

struct ContentView: View {

    @State var spinController: SpinController
    @State private var availableWidth: CGFloat = 320

    init() {
        self.spinController = SpinController()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
                VStack {
                    TabView {
                        NavigationStack {
                            SpinnerBoardView(spinController: $spinController)
                                .navigationTitle("Spinner")
                        }
                        .tabItem {
                            Label("Spinner", systemImage:
                                    "arrow.trianglehead.2.counterclockwise.rotate.90")
                        }
                        NavigationStack {
                            HistoryView(spinController: $spinController)
                                .navigationTitle("History")
                        }
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
                    Spacer(minLength: 50)
                }
#if !targetEnvironment(macCatalyst)
            AdMobBannerView()
                .frame(height: 50)
#endif
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
