//
//  FloatingMiniPlayerView.swift
//  Slipi
//

import SwiftUI

struct FloatingMiniPlayerView: View {
    @ObservedObject var mixer: MixerEngine

    private let imageSize: CGFloat = 35
    private let maxImages = 3
    private let overlapOffset: CGFloat = 22

    private var displayedTracks: [TrackChannel] {
        Array(mixer.tracks.prefix(maxImages))
    }

    var body: some View {
        if !mixer.tracks.isEmpty {
            HStack(spacing: 12) {
                iconStack

                VStack(alignment: .leading, spacing: 2) {
                    Text("Current Mix")
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(.white)

                    Text(mixer.tracks.count == 1 ? "1 Item Mixed" : "\(mixer.tracks.count) Items Mixed")
                        .font(.subheadline.weight(.light))
                        .foregroundStyle(.white.opacity(0.8))
                }

                Spacer()

                Button(action: mixer.togglePlayPause) {
                    Image(systemName: mixer.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
    }

    private var iconStack: some View {
        ZStack {
            ForEach(Array(displayedTracks.enumerated()), id: \.element.id) { index, track in
                ZStack {
                    Circle()
                        .fill(Color.brandOrange)
                        .stroke(.white.opacity(0.8), lineWidth: 1)
                    Image(systemName: track.iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(8)
                        .foregroundStyle(.white)
                }
                .frame(width: imageSize, height: imageSize)
                .offset(x: iconOffset(for: index))
                .zIndex(Double(maxImages - index))
            }
        }
        .frame(width: CGFloat(displayedTracks.count - 1) * overlapOffset + imageSize)
    }

    private func iconOffset(for index: Int) -> CGFloat {
        CGFloat(index) * overlapOffset - CGFloat(displayedTracks.count - 1) * overlapOffset / 2
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.brandBackground.ignoresSafeArea()
        FloatingMiniPlayerView(mixer: .shared)
    }
}
