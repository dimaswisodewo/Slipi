//
//  SliderSettingRow.swift
//  Slipi
//
//  Created by Rif'an Ardiansyah on 22/05/26.
//

import SwiftUI

struct SliderSettingRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let value: String
    @Binding var progress: Double

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 11) {
                SettingIcon(systemName: icon)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Palette.textPrimary)
                    Text(subtitle)
                        .font(.caption2)
                        .foregroundStyle(Palette.textSecondary)
                }

                Spacer()

                Text(value)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Palette.textMuted)
            }

            Slider(value: $progress, in: 0...1)
                .tint(Palette.sauce)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .overlay(alignment: .bottom) { RowDivider() }
    }
}

#Preview {
    SliderSettingRow(
        icon: "close",
        title: "Title",
        subtitle: "Subtitle",
        value: "value",
        progress: .constant(1)
    )
}
