//
//  HistoryView.swift
//  GameSpinner
//
//  Created by Steve Rose on 8/23/25.
//

import SwiftUI

struct HistoryView: View {
    @Binding var spinController: SpinController

    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button("Clear") {
                    spinController.clearHistory()
                }
                .padding(.top)
                .padding(.trailing)
            }
            let _ = spinController.spinning
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    ForEach(spinController.history.getItems(), id: \.index) { spinResult in
                        SpinResultDisplay(spinResult: spinResult)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var spinController = SpinController()
    let _ = spinController.history.add(SpinResult(appendage: Appendage.leftFoot, landingColor: LandingColor.blue))
    let _ = spinController.history.add(SpinResult(appendage: Appendage.leftFoot, landingColor: LandingColor.blue))
    let _ = spinController.history.add(SpinResult(appendage: Appendage.rightFoot, landingColor: LandingColor.yellow))
    let _ = spinController.history.add(SpinResult(appendage: Appendage.leftHand, landingColor: LandingColor.red))
    let _ = spinController.history.add(SpinResult(appendage: Appendage.rightHand, landingColor: LandingColor.green))
    HistoryView(spinController: $spinController)
}


