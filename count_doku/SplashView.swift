//
//  SplashView.swift
//  count_doku
//
//  Created by Tien Dat on 2/12/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isRotating = false // Trạng thái xoay
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [
                Color(UIColor.hexEBFF9B),
                Color(UIColor.hex8ED1D1),
                Color(UIColor.hexBB79D2),
            ]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            rotatingImage(
                imageName: "blob_shape_1",
                clockwise: false
            )
            rotatingImage(
                imageName: "blob_shape_2"
            )
            rotatingImage(
                imageName: "blob_shape_3",
                clockwise: false
            )
            rotatingImage(
                imageName: "blob_shape_4"
            )
            VStack(spacing: 14) {
                Text("COUNT")
                    .font(Font(StyleKit.appFont(with: .xxLarge)))
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                Text("DOKU")
                    .font(Font(StyleKit.appFont(with: .xLarge)))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
        }
    }
}
extension SplashView {
    private func rotatingImage(
        imageName: String,
        clockwise: Bool = true,
        duration: Double = 15
    ) -> some View {
        Image(imageName)
            .rotationEffect(.degrees(isRotating ? (clockwise ? 360 : -360) : 0))
            .animation(
                Animation.linear(duration: duration)
                    .repeatForever(autoreverses: false),
                value: isRotating
            )
            .onAppear {
                isRotating = true
            }
    }
}

#Preview {
    SplashView()
}
