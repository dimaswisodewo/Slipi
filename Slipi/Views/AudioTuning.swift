//
//  AudioTuning.swift
//  challange 2
//
//  Created by Gracia Adonay Efendi on 22/05/26.
//

import SwiftUI

struct AudioTuning: View {
    @Environment(\.dismiss) private var dismiss
    @State private var volume: Double = 50
    @State private var bass: Double = 50
    @State private var treble: Double = 50
    @State private var playbackSpeed: Double = 1

    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("Audio Tuning")
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .semibold))

                Spacer()

                Button("Done") {
                    dismiss()
                }
                .foregroundColor(.blue)
                .font(.system(size: 17, weight: .semibold))
            }
            .padding(.top, 28)

            VStack(spacing: 24) {
                TuningSliderRow(
                    title: "Volume",
                    value: $volume,
                    range: 0...100,
                    displayedValue: "\(Int(volume))%"
                )

                TuningSliderRow(
                    title: "Bass",
                    value: $bass,
                    range: 0...100,
                    displayedValue: "\(Int(bass))%"
                )

                TuningSliderRow(
                    title: "Treble",
                    value: $treble,
                    range: 0...100,
                    displayedValue: "\(Int(treble))%"
                )

                TuningSliderRow(
                    title: "Playback Speed",
                    value: $playbackSpeed,
                    range: 0.5...2.0,
                    displayedValue: String(format: "%.1fx", playbackSpeed)
                )
            }

            Spacer()
        }
        .padding(.horizontal, 20)
        .background(Color.black.ignoresSafeArea())
    }
}

private struct TuningSliderRow: View {
    let title: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let displayedValue: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .semibold))

                Spacer()

                Text(displayedValue)
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 56, alignment: .trailing)
            }

            ZStack {
                Capsule()
                    .fill(Color.gray.opacity(0.35))
                    .frame(height: 4)

                Slider(value: $value, in: range)
                    .tint(.customOrange)
            }
        }
    }
}

#Preview {
    AudioTuning()
}
