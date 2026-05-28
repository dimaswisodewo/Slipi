//
//  FavoritesRemixView.swift
//  Slipi
//
//  Created by Muhammad Syukron Jazila on 23/05/26.
//

import SwiftUI
import SwiftData

struct FavoritesRemixView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SavedMix.updatedAt, order: .reverse) private var savedMixes: [SavedMix]
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "642816"),
                    .black,
                    .black,
                ],
                startPoint: UnitPoint(x: -0.4, y: 0.3),
                endPoint: UnitPoint(x: 0.6, y: 0.9)
            )
            .ignoresSafeArea()

            
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 18) {
                    
                    // HEADER
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text("Favorites")
                            .font(.system(.title, weight: .bold))
                            .foregroundStyle(.white)
                        
                        Text("Your saved relaxing remixes")
                            .foregroundStyle(.white.opacity(0.7))
                            .font(.system(.subheadline))
                    }
                    .padding(.top, 80)

                    
                    if savedMixes.isEmpty {
                        emptyState
                    } else {
                        LazyVStack(spacing: 10) {
                            ForEach(savedMixes) { mix in
                                CardMusicView(
                                    title: mix.title,
                                    items: mix.tracks.count,
                                    images: mix.orderedTracks.prefix(3).map(\.iconName),
                                    onClickAction: {
                                        SavedMixStore(modelContext: modelContext)
                                            .load(mix, into: .shared)
                                    },
                                    onRenameAction: { newTitle in
                                        save {
                                            try SavedMixStore(modelContext: modelContext)
                                                .rename(mix, to: newTitle)
                                        }
                                    },
                                    onUnfavoriteAction: {
                                        delete(mix)
                                    },
                                    onDeleteAction: {
                                        delete(mix)
                                    }
                                )
                            }
                        }
                    }
                    
                    Spacer().frame(height: 120)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
     
        }
        .ignoresSafeArea()
        .alert("Unable to Update Favorite", isPresented: errorBinding) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Please try again.")
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart")
                .font(.system(size: 34, weight: .semibold))

            Text("No saved remixes yet")
                .font(.system(.headline, weight: .semibold))

            Text("Save your current mixer from the heart button.")
                .font(.system(.subheadline))
                .foregroundStyle(.white.opacity(0.65))
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 44)
    }

    private var errorBinding: Binding<Bool> {
        Binding(
            get: { errorMessage != nil },
            set: { isPresented in
                if !isPresented {
                    errorMessage = nil
                }
            }
        )
    }

    private func delete(_ mix: SavedMix) {
        save {
            if MixerEngine.shared.activeMixID == mix.id {
                MixerEngine.shared.activeMixID = nil
            }
            try SavedMixStore(modelContext: modelContext).delete(mix)
        }
    }

    private func save(_ action: () throws -> Void) {
        do {
            try action()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    FavoritesRemixView()
        .modelContainer(for: [SavedMix.self, SavedMixTrack.self], inMemory: true)
}
