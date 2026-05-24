//
//  CircleIcon.swift
//  Slipi
//
//  Created by Muhammad Syukron Jazila on 24/05/26.
//

import SwiftUI

struct CircleIcon: View {
    
    enum IconType {
        case system(String)
        case asset(String)
    }
    
    var icon: IconType
    var size: CGFloat = 35
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(hex: "BC3B15"),
                            Color(hex: "5F2514")
                        ]),
                        center: .topLeading,
                        startRadius: 5,
                        endRadius: size
                    )
                )
                .overlay {
                    // highlight utama
                    Circle()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.95),
                                    Color.white.opacity(0.45),
                                    Color.white.opacity(0.22),
                                    Color.white.opacity(0.35)
                                ],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            ),
                            lineWidth: 1.4
                        )
                }

                // subtle glossy ring
                .overlay {
                    Circle()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.10),
                                    Color.white.opacity(0.28),
                                    Color.white.opacity(0.12)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 0.6
                        )
                }
            
            iconView
        }
        .frame(width: size, height: size)
    }
    
    @ViewBuilder
    private var iconView: some View {
        switch icon {
        case .system(let name):
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .padding(size * 0.22)
            
        case .asset(let name):
            Image(name)
                .resizable()
                .scaledToFit()
                .padding(size * 0.18)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        
        CircleIcon(
            icon: .system("bird")
        )
        
        CircleIcon(
            icon: .system("wind")
        )
        
        CircleIcon(
            icon: .system("flame")
        )
    }
    .padding()
    .background(Color.black)
}
