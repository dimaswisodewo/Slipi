import SwiftUI
import SwiftData

struct MixerBottomSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SavedMix.updatedAt, order: .reverse) private var savedMixes: [SavedMix]
    @ObservedObject private var mixer: MixerEngine
    @State private var tuningTrack: TrackChannel?
    @State private var saveErrorMessage: String?

    init(mixer: MixerEngine = .shared) {
        self.mixer = mixer
    }

    var body: some View {
        VStack(spacing: 12) {
            Text("Audio Mixer")
                .font(.system(size: 23, weight: .semibold))
                .padding(.top, 40)

            if mixer.tracks.isEmpty {
                Text("No active tracks")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, minHeight: 120)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(mixer.tracks) { track in
                            MixerBottomSheetTrackRow(
                                track: track,
                                savedTrack: savedTrack(for: track)
                            ) {
                                tuningTrack = track
                            }
                        }
                    }
                    .padding(.top, 16)
                }
            }

            PlayPauseComponent(
                mixer: mixer,
                isFavorite: currentSavedMix != nil,
                canToggleFavorite: !mixer.tracks.isEmpty,
                onFavoriteToggle: toggleSavedMix
            )
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 16)
        .foregroundColor(.white)
        .blur(radius: tuningTrack == nil ? 0 : 6)
        .animation(.easeInOut(duration: 0.2), value: tuningTrack != nil)
        .presentationDetents([.medium, .large])
        .presentationBackground(.black)
        .sheet(item: $tuningTrack) { track in
            FXInspectorView(
                track: track,
                savedTrack: savedTrack(for: track)
            )
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        }
        .alert("Unable to Save Mix", isPresented: saveErrorBinding) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(saveErrorMessage ?? "Please try again.")
        }
    }

    private var currentSavedMix: SavedMix? {
        guard let id = mixer.activeMixID else { return nil }
        return savedMixes.first { $0.id == id }
    }

    private func savedTrack(for track: TrackChannel) -> SavedMixTrack? {
        currentSavedMix?.orderedTracks.first { $0.trackID == track.trackID }
    }

    private var saveErrorBinding: Binding<Bool> {
        Binding(
            get: { saveErrorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    saveErrorMessage = nil
                }
            }
        )
    }

    private func toggleSavedMix() {
        do {
            try SavedMixStore(modelContext: modelContext).toggleSaved(mixer: mixer)
        } catch {
            saveErrorMessage = error.localizedDescription
        }
    }
}

private struct MixerBottomSheetTrackRow: View {
    @ObservedObject var track: TrackChannel
    var savedTrack: SavedMixTrack?
    var onTuningTap: () -> Void

    var body: some View {
        AudioSliderComponent(
            title: savedTrack?.name ?? track.name,
            systemImageName: savedTrack?.iconName ?? track.iconName,
            sliderValue: volumeBinding,
            onTuningTap: onTuningTap
        )
    }

    private var volumeBinding: Binding<Double> {
        Binding(
            get: { Double(track.volume) * 100 },
            set: { newValue in
                let newVolume = Float(newValue / 100)
                track.volume = newVolume
                if let savedTrack = savedTrack {
                    savedTrack.volume = newVolume
                    savedTrack.mix?.updatedAt = .now
                }
            }
        )
    }
}


#Preview {
    MixerBottomSheet()
        .modelContainer(for: [SavedMix.self, SavedMixTrack.self], inMemory: true)
}
