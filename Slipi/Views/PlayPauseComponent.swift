//
//  PlayPauseComponent.swift
//  challange 2
//
//  Created by Gracia Adonay Efendi on 22/05/26.
//

import SwiftUI

struct PlayPauseComponent: View {
    @ObservedObject var mixer: MixerEngine
    @State private var isFavorite = false

    var body: some View {
        HStack(spacing: 24) {
            Button {
                isFavorite.toggle()
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.system(size: 24, weight: .semibold))
            }
            .buttonStyle(CircleIconButtonStyle())

            Button {
                mixer.togglePlayPause()
            } label: {
                Image(systemName: mixer.isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 28, weight: .semibold))
            }
            .buttonStyle(CircleIconButtonStyle(size: 72))

            Button {

            } label: {
                Image(systemName: "timer")
                    .font(.system(size: 24, weight: .semibold))
            }
            .buttonStyle(CircleIconButtonStyle())
        }
    }
}

private struct CircleIconButtonStyle: ButtonStyle {
    let size: CGFloat

    init(size: CGFloat = 60) {
        self.size = size
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.customBrightOrange)
            .frame(width: size, height: size)
            .background(Color.white)
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlayPauseComponent(mixer: .shared)
    }
}
