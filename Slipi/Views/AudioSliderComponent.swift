//
//  reusablecompo.swift
//  challange 2
//
//  Created by Gracia Adonay Efendi on 22/05/26.
//

import SwiftUI

struct AudioSliderComponent: View {
    let title: String
    let systemImageName: String
    @Binding var sliderValue: Double
    var onTuningTap: () -> Void = {}

    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundStyle(.white)
                .font(.system(size: 25, weight: .medium))
                .frame(width: 80, height: 80)
                .background(
                    LinearGradient(
                        colors: [
                            Color(hex: "BC3B15"),
                            Color(hex: "5F2514")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    )
                )

            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .semibold))

                ZStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.35))
                        .frame(height: 4)

                    Slider(value: $sliderValue, in: 0...100)
                        .tint(.customOrange)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 20)

            Button {
                onTuningTap()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.customBrightOrange)
            }
            .padding(10)
        }
    }
}

#Preview {
    @Previewable @State var rainSliderValue: Double = 1
    @Previewable @State var windSliderValue: Double = 1
    @Previewable @State var thunderSliderValue: Double = 1

    VStack {
        AudioSliderComponent(
            title: "Rain",
            systemImageName: "cloud.rain.fill",
            sliderValue: $rainSliderValue
        )
        AudioSliderComponent(
            title: "Wind",
            systemImageName: "wind",
            sliderValue: $windSliderValue
        )
        AudioSliderComponent(
            title: "Thunder",
            systemImageName: "cloud.bolt.rain.fill",
            sliderValue: $thunderSliderValue
        )
        
    }
    .padding()
    .background(Color.black)
}

