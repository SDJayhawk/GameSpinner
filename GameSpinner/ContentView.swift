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
                    Spacer(minLength: 100)
                }
#if !targetEnvironment(macCatalyst)
            bannerAd()
#endif
        }
    }
#if !targetEnvironment(macCatalyst)
    func bannerAd() -> some View {
        GeometryReader { geo in
            BannerAdView(width: geo.size.width)
                .frame(width: geo.size.width, height: 50, alignment: .center)
                .ignoresSafeArea(edges: .bottom)
                .onAppear() {
                    availableWidth = geo.size.width
                }
                .onChange(of: geo.size.width) {
                    availableWidth = $1
                }
        }
        .frame(height: 50)
    }
#endif
}

#Preview {
    ContentView()
}
