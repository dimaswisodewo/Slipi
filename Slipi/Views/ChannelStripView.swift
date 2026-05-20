//
//  ChannelStripView.swift
//  Slipi
//

import SwiftUI

struct ChannelStripView: View {
    @ObservedObject var track: TrackChannel // Observes local mutations
    var openSettings: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(track.name)
                .font(.caption).bold()
                .frame(width: 90, height: 35)
                .multilineTextAlignment(.center)
            
            // Volume control mapping directly to engine node volume
            Slider(value: $track.volume, in: 0...1)
                .frame(height: 140)
                .rotationEffect(.degrees(-90))
                .padding(.vertical)
            
            Button(action: openSettings) {
                Image(systemName: "slider.horizontal.3")
                    .font(.headline)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}
