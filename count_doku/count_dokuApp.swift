//
//  count_dokuApp.swift
//  count_doku
//
//  Created by Tien Dat on 2/12/24.
//

import SwiftUI

@main
struct count_dokuApp: App {
    @State private var showSplash = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    HomeView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    withAnimation {
                        showSplash = false
                    }
                }
            }
        }
    }
}
