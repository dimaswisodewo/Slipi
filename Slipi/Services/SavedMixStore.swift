//
//  SavedMixStore.swift
//  Slipi
//

import Foundation
import SwiftData

@MainActor
struct SavedMixStore {
    enum StoreError: LocalizedError {
        case emptyMix

        var errorDescription: String? {
            switch self {
            case .emptyMix:
                return "Add at least one track before saving a mix."
            }
        }
    }

    let modelContext: ModelContext

    func snapshot(from mixer: MixerEngine) throws -> SavedMixSnapshot {
        let tracks = mixer.mixTrackSnapshots()
        guard !tracks.isEmpty else {
            throw StoreError.emptyMix
        }

        return SavedMixSnapshot(tracks: tracks)
    }

    func savedMix(matching mixer: MixerEngine) -> SavedMix? {
        guard let id = mixer.activeMixID else { return nil }
        return savedMix(id: id)
    }

    func savedMix(id: UUID) -> SavedMix? {
        var descriptor = FetchDescriptor<SavedMix>(
            predicate: #Predicate { mix in
                mix.id == id
            }
        )
        descriptor.fetchLimit = 1

        return try? modelContext.fetch(descriptor).first
    }

    @discardableResult
    func toggleSaved(mixer: MixerEngine) throws -> Bool {
        if let id = mixer.activeMixID, let savedMix = savedMix(id: id) {
            modelContext.delete(savedMix)
            mixer.activeMixID = nil
            try saveIfNeeded()
            return false
        }

        let snapshot = try snapshot(from: mixer)
        let mix = snapshot.makeSavedMix()
        modelContext.insert(mix)
        mixer.activeMixID = mix.id
        try saveIfNeeded()
        return true
    }

    func delete(_ mix: SavedMix) throws {
        modelContext.delete(mix)
        try saveIfNeeded()
    }

    func rename(_ mix: SavedMix, to title: String) throws {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        mix.title = trimmedTitle
        mix.updatedAt = .now
        try saveIfNeeded()
    }

    func load(_ mix: SavedMix, into mixer: MixerEngine) {
        mixer.loadSavedMix(mix)
    }

    private func saveIfNeeded() throws {
        guard modelContext.hasChanges else { return }
        try modelContext.save()
    }
}

struct SavedMixSnapshot {
    let tracks: [SavedMixTrackSnapshot]

    var title: String {
        let names = tracks.prefix(2).map(\.name)
        guard !names.isEmpty else { return "Saved Mix" }

        if tracks.count > 2 {
            return "\(names.joined(separator: " + ")) + \(tracks.count - 2)"
        }

        return names.joined(separator: " + ")
    }

    func makeSavedMix() -> SavedMix {
        SavedMix(
            id: UUID(),
            title: title,
            tracks: tracks.map { snapshot in
                SavedMixTrack(
                    trackID: snapshot.trackID,
                    name: snapshot.name,
                    fileName: snapshot.fileName,
                    iconName: snapshot.iconName,
                    order: snapshot.order,
                    volume: snapshot.volume,
                    pan: snapshot.pan,
                    speed: snapshot.speed,
                    bass: snapshot.bass,
                    mid: snapshot.mid,
                    treble: snapshot.treble
                )
            }
        )
    }
}

struct SavedMixTrackSnapshot {
    let trackID: String
    let name: String
    let fileName: String
    let iconName: String
    let order: Int
    let volume: Float
    let pan: Float
    let speed: Float
    let bass: Float
    let mid: Float
    let treble: Float

    var availableTrack: AvailableTrack {
        AvailableTrack(name: name, fileName: fileName, iconName: iconName)
    }
}
