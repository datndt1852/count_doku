//
//  SplashView.swift
//  count_doku
//
//  Created by Tien Dat on 2/12/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Image(systemName: "star.fill") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                Text("Welcome!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
        }
    }
}

#Preview {
    SplashView()
}
