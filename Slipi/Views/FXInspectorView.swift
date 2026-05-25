//
//  FXInspectorView.swift
//  Slipi
//

import SwiftUI

struct FXInspectorView: View {
    @ObservedObject var track: TrackChannel
    var savedTrack: SavedMixTrack?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DSP Tuning: \(displayName)")
                .font(.headline)
                .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Panning Balance (\(formattedPan))")
                Slider(value: panBinding, in: -1...1)
            }
            
            VStack(alignment: .leading) {
                Text("Playback Speed (\(formattedSpeed))")
                Slider(value: speedBinding, in: 0.5...2.0)
            }
            
            HStack {
                VStack { Slider(value: bassBinding, in: -12...12); Text("Bass \(formattedGain(track.bass))") }
                VStack { Slider(value: midBinding, in: -12...12); Text("Mid \(formattedGain(track.mid))") }
                VStack { Slider(value: trebleBinding, in: -12...12); Text("Treble \(formattedGain(track.treble))") }
            }
            .frame(height: 120)
            
            Spacer()
        }
        .padding()
    }

    private var displayName: String {
        savedTrack?.name ?? track.name
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

    private var formattedPan: String {
        String(format: "%.2f", track.pan)
    }

    private var formattedSpeed: String {
        String(format: "%.2fx", track.speed)
    }

    private func formattedGain(_ value: Float) -> String {
        String(format: "%+.1f dB", value)
    }
}
