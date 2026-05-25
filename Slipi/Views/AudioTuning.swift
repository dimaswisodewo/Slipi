//
//  AudioTuning.swift
//  Slipi
//
//  Created by Gracia Adonay Efendi on 22/05/26.
//

import SwiftUI

struct AudioTuning: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var track: TrackChannel
    var savedTrack: SavedMixTrack? = nil

    private var displayName: String {
        savedTrack?.name ?? track.name
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Audio Tuning: \(displayName)")
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .semibold))
                    .lineLimit(1)

                Spacer()

                Button("Done") {
                    dismiss()
                }
                .foregroundColor(.blue)
                .font(.system(size: 17, weight: .semibold))
            }
            .padding(.top, 28)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 24) {
                    TuningSliderRow(
                        title: "Volume",
                        value: volumeBinding,
                        range: 0...1,
                        displayedValue: "\(Int(track.volume * 100))%"
                    )

                    TuningSliderRow(
                        title: "Panning Balance",
                        value: panBinding,
                        range: -1...1,
                        displayedValue: String(format: "%.2f", track.pan)
                    )

                    TuningSliderRow(
                        title: "Playback Speed",
                        value: speedBinding,
                        range: 0.5...2.0,
                        displayedValue: String(format: "%.1fx", track.speed)
                    )

                    TuningSliderRow(
                        title: "Bass",
                        value: bassBinding,
                        range: -12...12,
                        displayedValue: formattedGain(track.bass)
                    )

                    TuningSliderRow(
                        title: "Mid",
                        value: midBinding,
                        range: -12...12,
                        displayedValue: formattedGain(track.mid)
                    )

                    TuningSliderRow(
                        title: "Treble",
                        value: trebleBinding,
                        range: -12...12,
                        displayedValue: formattedGain(track.treble)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 28)
            }
        }
        .background(Color.black.ignoresSafeArea())
    }

    // MARK: - Bindings

    private var volumeBinding: Binding<Float> {
        Binding(
            get: { track.volume },
            set: { newValue in
                track.volume = newValue
                savedTrack?.volume = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private var panBinding: Binding<Float> {
        Binding(
            get: { track.pan },
            set: { newValue in
                track.pan = newValue
                savedTrack?.pan = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private var speedBinding: Binding<Float> {
        Binding(
            get: { track.speed },
            set: { newValue in
                track.speed = newValue
                savedTrack?.speed = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private var bassBinding: Binding<Float> {
        Binding(
            get: { track.bass },
            set: { newValue in
                track.bass = newValue
                savedTrack?.bass = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private var midBinding: Binding<Float> {
        Binding(
            get: { track.mid },
            set: { newValue in
                track.mid = newValue
                savedTrack?.mid = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private var trebleBinding: Binding<Float> {
        Binding(
            get: { track.treble },
            set: { newValue in
                track.treble = newValue
                savedTrack?.treble = newValue
                savedTrack?.mix?.updatedAt = .now
            }
        )
    }

    private func formattedGain(_ value: Float) -> String {
        String(format: "%+.1f dB", value)
    }
}

private struct TuningSliderRow: View {
    let title: String
    @Binding var value: Float
    let range: ClosedRange<Float>
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
                    .frame(width: 70, alignment: .trailing)
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
