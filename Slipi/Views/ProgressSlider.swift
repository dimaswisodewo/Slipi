//
//  ProgressSlider.swift
//  Slipi
//
//  Created by Rif'an Ardiansyah on 22/05/26.
//

import SwiftUI

struct ProgressSlider: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let clampedProgress = min(max(progress, 0), 1)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Palette.cardInset)
                    .frame(height: 5)

                Capsule()
                    .fill(Palette.sauce)
                    .frame(width: max(5, width * clampedProgress), height: 5)

                Circle()
                    .fill(Palette.chefHat)
                    .frame(width: 16, height: 16)
                    .shadow(color: .black.opacity(0.22), radius: 4, x: 0, y: 2)
                    .offset(x: min(max(0, width * clampedProgress - 8), max(0, width - 16)))
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        progress = min(max(value.location.x / width, 0), 1)
                    }
            )
        }
        .frame(height: 18)
    }
}

#Preview {
    ProgressSlider(progress: .constant(1.0))
}
