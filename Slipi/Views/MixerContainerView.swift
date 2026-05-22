//
//  MixerContainerView.swift
//  Slipi
//

import SwiftUI

struct MixerContainerView: View {
    @Environment(NavigationRouter.self) private var router
    @ObservedObject private var engine = MixerEngine.shared
    
    private struct AvailableTrack: Identifiable {
        let id = UUID()
        let name: String
        let fileName: String
    }
    
    private let availableTracks: [AvailableTrack] = [
        AvailableTrack(name: "Dry Leaves", fileName: "dry-leaves"),
        AvailableTrack(name: "Fish Moving", fileName: "fish-moving"),
        AvailableTrack(name: "Light Rain", fileName: "light-rain"),
        AvailableTrack(name: "Thunder Strike", fileName: "thunder-strike"),
        AvailableTrack(name: "Water Flowing", fileName: "water-flowing"),
        AvailableTrack(name: "Wind Blowing", fileName: "wind-blowing")
    ]
    
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
                    ForEach(availableTracks) { trackDef in
                        let activeTrack = engine.tracks.first(where: { $0.name == trackDef.name })
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Toggle(trackDef.name, isOn: Binding(
                                    get: { activeTrack != nil },
                                    set: { newValue in
                                        if newValue {
                                            engine.addTrack(displayName: trackDef.name, fileName: trackDef.fileName)
                                        } else if let id = activeTrack?.id {
                                            engine.removeTrack(id: id)
                                        }
                                    }
                                ))
                                .font(.headline)
                                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                            }
                            
                            if let track = activeTrack {
                                HStack(spacing: 16) {
                                    Slider(value: Binding(
                                        get: { track.volume },
                                        set: { track.volume = $0 }
                                    ), in: 0...1)
                                    
                                    Button(action: { router.presentSheet(.equalizer(track: track)) }) {
                                        Image(systemName: "slider.horizontal.3")
                                            .font(.headline)
                                    }
                                    .buttonStyle(.bordered)
                                }
                                .padding(.leading, 8)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .animation(.spring(), value: activeTrack != nil)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

#Preview {
    PreviewRouterWrapper {
        MixerContainerView()
    }
}
