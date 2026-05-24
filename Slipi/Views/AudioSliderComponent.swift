//
//  reusablecompo.swift
//  challange 2
//
//  Created by Gracia Adonay Efendi on 22/05/26.
//

import SwiftUI

struct AudioSliderComponent: View {
    
    @Binding var sliderValue: Double
    var onTuningTap: () -> Void = {}
    var body: some View {
        HStack {
            Image(systemName: "cloud.rain.fill")
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
                Text("Rain")
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
                    .frame(width: 24, height:24)
                    .foregroundStyle(Color.customBrightOrange)
            }
            
            .padding(10)
            
        }
    }
}

struct WindSliderComponent: View {
    @Binding var sliderValue: Double
    var onTuningTap: () -> Void = {}

    var body: some View {
        HStack {
            Image(systemName: "wind")
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
                Text("Wind")
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

struct ThunderSliderComponent: View {
    @Binding var sliderValue: Double
    var onTuningTap: () -> Void = {}

    var body: some View {
        HStack {
            Image(systemName: "cloud.bolt.rain.fill")
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
                Text("Thunder")
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
        AudioSliderComponent(sliderValue: $rainSliderValue)
        WindSliderComponent(sliderValue: $windSliderValue)
        ThunderSliderComponent(sliderValue: $thunderSliderValue)
    }
    .padding()
    .background(Color.black)
}
