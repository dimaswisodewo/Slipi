//
//  FXInspectorView.swift
//  Slipi
//

import SwiftUI

struct FXInspectorView: View {
    @ObservedObject var track: TrackChannel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("DSP Tuning: \(track.name)")
                .font(.headline)
                .padding(.top)
            
            VStack(alignment: .leading) {
                Text("Panning Balance")
                Slider(value: $track.pan, in: -1...1)
            }
            
            VStack(alignment: .leading) {
                Text("Playback Speed (\(String(format: "%.2fx", track.speed)))")
                Slider(value: $track.speed, in: 0.5...2.0)
            }
            
            HStack {
                VStack { Slider(value: $track.bass, in: -12...12); Text("Bass") }
                VStack { Slider(value: $track.mid, in: -12...12); Text("Mid") }
                VStack { Slider(value: $track.treble, in: -12...12); Text("Treble") }
            }
            .frame(height: 120)
            
            Spacer()
        }
        .padding()
    }
}
