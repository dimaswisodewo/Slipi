//
//  MixerContainerView.swift
//  Slipi
//

import SwiftUI

struct MixerContainerView: View {
    @Environment(NavigationRouter.self) private var router
    @StateObject private var engine = MixerEngine()
    
    var body: some View {
        VStack {
            HStack {
                Text("Audio Mixer")
                    .font(.title2).bold()
                Spacer()
                Button(action: { engine.togglePlayPause() }) {
                    Image(systemName: engine.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44))
                }
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(engine.tracks) { track in
                        ChannelListItemView(track: track) {
                            router.presentSheet(.equalizer(track: track))
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            // Load local wav bundles
            engine.loadLocalManifest([
                "Dry Leaves": "dry-leaves",
                "Fish Moving": "fish-moving",
                "Light Rain": "light-rain",
                "Thunder Strike": "thunder-strike",
                "Water Flowing": "water-flowing",
                "Wind Blowing": "wind-blowing"
            ])
        }
    }
}

#Preview {
    PreviewRouterWrapper {
        MixerContainerView()
    }
}
