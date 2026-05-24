import SwiftUI

struct MixerBottomSheet: View {
    @ObservedObject private var mixer: MixerEngine
    @State private var tuningTrack: TrackChannel?

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
                            MixerBottomSheetTrackRow(track: track) {
                                tuningTrack = track
                            }
                        }
                    }
                    .padding(.top, 16)
                }
            }

            PlayPauseComponent(mixer: mixer)
                .padding(.bottom, 32)
        }
        .padding(.horizontal, 16)
        .foregroundColor(.white)
        .blur(radius: tuningTrack == nil ? 0 : 6)
        .animation(.easeInOut(duration: 0.2), value: tuningTrack != nil)
        .presentationDetents([.medium, .large])
        .presentationBackground(.black)
        .sheet(item: $tuningTrack) { track in
            FXInspectorView(track: track)
                .presentationDetents([.medium, .large])
                .presentationBackground(.black)
        }
    }
}

private struct MixerBottomSheetTrackRow: View {
    @ObservedObject var track: TrackChannel
    var onTuningTap: () -> Void

    var body: some View {
        AudioSliderComponent(
            title: track.name,
            systemImageName: track.iconName,
            sliderValue: volumeBinding,
            onTuningTap: onTuningTap
        )
    }

    private var volumeBinding: Binding<Double> {
        Binding(
            get: { Double(track.volume) * 100 },
            set: { track.volume = Float($0 / 100) }
        )
    }
}


#Preview {
    MixerBottomSheet()
}
