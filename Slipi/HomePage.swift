//
//  SwiftUIView.swift
//  Slipi
//
//  Created by Ahmad Yasri Zaenuri on 21/05/26.
//

import SwiftUI

// MARK: - Models
 
struct SoundItem: Identifiable {
    let id: String
    let name: String
    let icon: String // SF Symbol name
    let track: AvailableTrack?
    
    init(name: String, icon: String, track: AvailableTrack? = nil) {
        self.id = track?.id ?? name
        self.name = name
        self.icon = icon
        self.track = track
    }

    init(track: AvailableTrack, name: String? = nil, icon: String? = nil) {
        self.id = track.id
        self.name = name ?? track.name
        self.icon = icon ?? track.iconName
        self.track = track
    }
}
 
struct SoundCategory: Identifiable {
    let id = UUID()
    let name: String
    let items: [SoundItem]
}
 
// MARK: - Sample Data
 
let sampleCategories: [SoundCategory] = [
    SoundCategory(name: "Nature", items: [
        SoundItem(track: .windBlowing, name: "Wind"),
        SoundItem(name: "Campfire", icon: "flame"),
        SoundItem(name: "Bird", icon: "bird"),
        SoundItem(track: .thunderStrike, name: "Thunder"),
        SoundItem(track: .lightRain, name: "Rain"),
        SoundItem(name: "Ocean", icon: "water.waves"),
        SoundItem(track: .dryLeaves, name: "Forest", icon: "tree"),
        SoundItem(track: .waterFlowing, name: "Creek"),
        SoundItem(track: .fishMoving, name: "Fish")
    ]),
    SoundCategory(name: "Weather", items: [
        SoundItem(track: .windBlowing, name: "Wind"),
        SoundItem(name: "Storm", icon: "cloud.bolt.rain"),
        SoundItem(track: .lightRain, name: "Rain", icon: "cloud.drizzle"),
        SoundItem(track: .thunderStrike, name: "Thunder"),
        SoundItem(name: "Snow", icon: "snowflake"),
        SoundItem(name: "Fog", icon: "cloud.fog"),
        SoundItem(name: "Hail", icon: "cloud.hail"),
        SoundItem(name: "Blizzard", icon: "wind.snow")
    ]),
    SoundCategory(name: "Brainwaves", items: [
        SoundItem(name: "Alpha", icon: "waveform.path"),
        SoundItem(name: "Beta", icon: "waveform"),
        SoundItem(name: "Theta", icon: "waveform.path.ecg"),
        SoundItem(name: "Delta", icon: "chart.xyaxis.line"),
        SoundItem(name: "Gamma", icon: "waveform.badge.plus"),
        SoundItem(name: "Focus", icon: "brain.head.profile"),
        SoundItem(name: "Relax", icon: "sparkles"),
        SoundItem(name: "Sleep", icon: "moon.zzz")
    ])
]
 
let filterTabs = ["Nature", "Weather", "Brainwaves", "Colored Noise", "ASMR"]
 
// MARK: - Color Theme
 
// MARK: - Sound Card View
 
struct SoundCardView: View {
    let item: SoundItem
    @ObservedObject private var engine = MixerEngine.shared
    @State private var isPressed = false
 
    private var isActive: Bool {
        guard let track = item.track else { return false }
        return engine.isTrackActive(track)
    }

    var body: some View {
        Button(action: handleTap) {
            content
        }
        .buttonStyle(.plain)
    }

    private var content: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        isActive ?
                        LinearGradient(
                            colors: [Color.brandOrange, Color.brandOrangeDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ) :
                        LinearGradient(
                            colors: [Color.white.opacity(0.1), Color.white.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(isActive ? 0.8 : 0), lineWidth: 2)
                    )
                    .shadow(color: isActive ? Color.brandOrange.opacity(0.4) : Color.clear, radius: 8, x: 0, y: 4)
 
                Image(systemName: item.icon)
                    .resizable()
                    .scaledToFit()
                    .padding(22)
                    .foregroundStyle(isActive ? .white : .white.opacity(0.4))
                    .fontWeight(.light)
            }
 
            Text(item.name)
                .font(.system(size: 13, weight: isActive ? .medium : .regular))
                .foregroundStyle(isActive ? .white : .white.opacity(0.6))
        }
        .scaleEffect(isPressed ? 0.94 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: isPressed)
    }

    private func handleTap() {
        withAnimation {
            isPressed = true
        }

        if let track = item.track {
            if let activeTrack = engine.activeTrack(for: track) {
                engine.removeTrack(id: activeTrack.id)
            } else {
                engine.addTrack(track)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation {
                isPressed = false
            }
        }
    }
}
 
// MARK: - Category Section View
 
struct CategorySectionView: View {
    let category: SoundCategory
 
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
 
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(category.name)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white.opacity(0.5))
                .padding(.horizontal, 16)
 
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(category.items) { item in
                    SoundCardView(item: item)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
 
// MARK: - Filter Tab View
 
struct FilterTabView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
 
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.brandOrange : Color.white.opacity(0.1))
                )
        }
        .buttonStyle(.plain)
    }
}
 
// MARK: - Main Content View
 
struct HomePage: View {
    @State private var searchText = ""
    @State private var selectedTab = "Nature"
    @State private var selectedNavTab = 0
 
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background gradient
            LinearGradient(
                colors: [
                    Color(red: 0.25, green: 0.08, blue: 0.02),
                    Color.brandBackground
                ],
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
 
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
 
                        // MARK: Header
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Image(systemName: "wind.snow")
                                    .font(.system(size: 36, weight: .thin))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 4)
 
                                Text("Good Evening, Dea!")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
 
                        // MARK: Search Bar
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white.opacity(0.5))
                            TextField("", text: $searchText,
                                      prompt: Text("Search weather, nature, binaural...")
                                .foregroundColor(.white.opacity(0.4))
                            )
                            .foregroundColor(.white)
                            .font(.system(size: 15))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.08))
                        )
                        .padding(.horizontal, 16)
 
                        // MARK: Filter Tabs
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(filterTabs, id: \.self) { tab in
                                    FilterTabView(
                                        title: tab,
                                        isSelected: selectedTab == tab
                                    ) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedTab = tab
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
 
                        // MARK: Category Sections
                        ForEach(sampleCategories) { category in
                            CategorySectionView(category: category)
                        }
 
                        // Bottom padding for tab bar
                        Spacer().frame(height: 90)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
 
// MARK: - Preview

#Preview {
    HomePage()
}
