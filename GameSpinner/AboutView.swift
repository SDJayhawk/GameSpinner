//
//  AboutView.swift
//  GameSpinner
//
//  Created by Steve Rose on 8/23/25.
//

import SwiftUI

struct AboutView: View {
        
    var body: some View {
                
        VStack(alignment: .center) {
            Text(getAppName())
                .font(.title)
            Text("v\(getVersion())")
        }
        .padding(.bottom)
        VStack(alignment: .leading) {
            Text("Use this app as a replacement for the spinner included with your TWISTER® game.")
                .padding(.bottom)
            Text("Instructions")
                .font(.headline)
            Text("Use your finger or other pointing device to spin the spinner then announce the result to the group.")
                .padding(.bottom)
            Text("Select History to see all previous spins. From the history tab, you can use the Clear button to start a new game.")
                .padding(.bottom)
            Text("Feedback")
                .font(.headline)
            Text("[Send comments, questions, and feature requests to](https://srosesoftware.com/spinner/)")
                .padding(.bottom)
            WriteReviewLink()

            Spacer()
        }
        .padding()
    }
    
    func getVersion() -> String {

        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown Version"
    }

    func getAppName() -> String {
        if let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            return displayName
        } else if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            return appName
        } else {
            return "Unknown App Name"
        }
    }
    
}

#Preview {
    AboutView()
}
