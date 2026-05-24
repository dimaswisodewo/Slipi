//
//  MixerContainerView.swift
//  Slipi
//

import SwiftUI

/// Main container view for the audio mixer feature.
/// It displays a global play/pause control and a list of all available sound tracks.
struct MixerContainerView: View {
    // Observes the shared audio engine. When tracks are added/removed, this view updates.
    @ObservedObject private var engine = MixerEngine.shared
    
    // Hardcoded list of available tracks.
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
            headerView
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(availableTracks) { track in
                        MixerTrackRowView(track: track, engine: engine)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
    }
    
    /// The top header containing the title and global play/pause button.
    private var headerView: some View {
        HStack {
            Text("Audio Mixer")
                .font(.title2).bold()
            Spacer()
            Button(action: { engine.togglePlayPause() }) {
                Image(systemName: engine.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 44))
            }
        }
    }
}

// MARK: - Subviews

/// Represents a single row in the mixer list.
/// Handles toggling the track on and off, which safely adds or removes it from the audio engine.
private struct MixerTrackRowView: View {
    let track: AvailableTrack
    // We observe the engine here to react when this specific track is added or removed.
    @ObservedObject var engine: MixerEngine
    
    // Computed property to check if this specific track is currently active (playing).
    private var activeTrack: TrackChannel? {
        engine.tracks.first(where: { $0.name == track.name })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // The toggle uses a custom binding to interface directly with the engine's state.
            Toggle(track.name, isOn: trackBinding)
                .font(.headline)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            // Only show the volume and EQ controls if the track is currently active.
            if let activeTrack {
                TrackControlView(track: activeTrack)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .animation(.spring(), value: activeTrack != nil)
    }
    
    /// A custom Binding that bridges the Toggle's boolean state with the Audio Engine's track list.
    /// - get: Returns true if the track is currently in the engine's active tracks.
    /// - set: Instructs the engine to add or remove the track when the user flips the toggle.
    private var trackBinding: Binding<Bool> {
        Binding(
            get: { activeTrack != nil },
            set: { newValue in
                if newValue {
                    engine.addTrack(displayName: track.name, fileName: track.fileName)
                } else if let id = activeTrack?.id {
                    engine.removeTrack(id: id)
                }
            }
        )
    }
}

/// Displays the volume slider and EQ settings button for an active track.
private struct TrackControlView: View {
    // By taking the TrackChannel as an @ObservedObject, we can directly bind to its @Published properties (like volume).
    @ObservedObject var track: TrackChannel
    // The router is used to present the EQ sheet.
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        HStack(spacing: 16) {
            // Because 'track' is an @ObservedObject, '$track.volume' provides a direct Binding to the volume property.
            Slider(value: $track.volume, in: 0...1)
            
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

#Preview {
    PreviewRouterWrapper {
        MixerContainerView()
    }
}
