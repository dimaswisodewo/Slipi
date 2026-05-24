//
//  ChannelListItemView.swift
//  Slipi
//

import SwiftUI

struct ChannelListItemView: View {
    @ObservedObject var track: TrackChannel // Observes local mutations
    var openSettings: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            Text(track.name)
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            
            // Volume control mapping directly to engine node volume
            Slider(value: $track.volume, in: 0...1)
            
            Button(action: openSettings) {
                Image(systemName: "slider.horizontal.3")
                    .font(.headline)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    if let fileURL = Bundle.main.url(forResource: "dry-leaves", withExtension: "wav"),
       let track = try? TrackChannel(name: "Test Track", fileURL: fileURL) {
        ChannelListItemView(track: track, openSettings: {})
            .padding()
    } else {
        ContentUnavailableView("Preview audio file missing", systemImage: "waveform.slash")
    }
}
