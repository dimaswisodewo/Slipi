//
//  AvailableTrack.swift
//  Slipi
//
//  Created by Meynabel Dimas Wisodewo on 24/05/26.
//

import Foundation

struct AvailableTrack: ModelPassable {
    var id: String { fileName }

    let name: String
    let fileName: String
    let iconName: String
}

extension AvailableTrack {
    static let arcticWind = AvailableTrack(name: "Arctic Wind", fileName: "Artic-Wind", iconName: "wind")
    static let autumnForest = AvailableTrack(name: "Autumn Forest", fileName: "autumn-forest", iconName: "leaf.fill")
    static let bats = AvailableTrack(name: "Bats", fileName: "bats", iconName: "bird")
    static let beads = AvailableTrack(name: "Beads", fileName: "beads", iconName: "circle.grid.3x3")
    static let bedSheets = AvailableTrack(name: "Bed Sheets", fileName: "bed-sheets", iconName: "bed.double")
    static let binaural174 = AvailableTrack(name: "Binaural 174Hz", fileName: "binaural-174hz", iconName: "waveform.path.ecg")
    static let binaural396 = AvailableTrack(name: "Binaural 396Hz", fileName: "binaural-396hz", iconName: "waveform.path.ecg")
    static let binaural417 = AvailableTrack(name: "Binaural 417Hz", fileName: "binaural-417hz", iconName: "waveform.path.ecg")
    static let binaural432 = AvailableTrack(name: "Binaural 432Hz", fileName: "binaural-432hz", iconName: "waveform.path.ecg")
    static let binaural528 = AvailableTrack(name: "Binaural 528Hz", fileName: "binaural-528hz", iconName: "waveform.path.ecg")
    static let binaural639 = AvailableTrack(name: "Binaural 639Hz", fileName: "binaural-639hz", iconName: "waveform.path.ecg")
    static let birdsChirping = AvailableTrack(name: "Birds Chirping", fileName: "Birds-Chirping", iconName: "bird")
    static let boilingWater = AvailableTrack(name: "Boiling Water", fileName: "boiling-water", iconName: "cup.and.saucer")
    static let bookPageTurning = AvailableTrack(name: "Book Page Turning", fileName: "book-page-turning", iconName: "book")
    static let bubbleWrap = AvailableTrack(name: "Bubble Wrap", fileName: "bubble-wrap", iconName: "bubbles.and.sparkles")
    static let bubblingMagma = AvailableTrack(name: "Bubbling Magma", fileName: "bubbling-magma", iconName: "flame")
    static let bullfrogs = AvailableTrack(name: "Bullfrogs", fileName: "bullfrogs", iconName: "tortoise")
    static let bumblebee = AvailableTrack(name: "Bumblebee", fileName: "bumblebee", iconName: "ant")
    static let catPurring = AvailableTrack(name: "Cat Purring", fileName: "cat-purring", iconName: "cat")
    static let chacalacaBirds = AvailableTrack(name: "Chacalaca Birds", fileName: "Chacalaca-birds", iconName: "bird")
    static let chickens = AvailableTrack(name: "Chickens", fileName: "chickens", iconName: "bird")
    static let cowsMoos = AvailableTrack(name: "Cows Moos", fileName: "cows-moos", iconName: "pawprint")
    static let crickets = AvailableTrack(name: "Crickets", fileName: "crickets", iconName: "ladybug")
    static let cuckooBirds = AvailableTrack(name: "Cuckoo Birds", fileName: "cuckoo-birds", iconName: "bird")
    static let deepBrownNoise = AvailableTrack(name: "Deep Brown Noise", fileName: "deep-brown-noise", iconName: "waveform")
    static let dryLeaves = AvailableTrack(name: "Dry Leaves", fileName: "dry-leaves", iconName: "leaf")
    static let ducks = AvailableTrack(name: "Ducks", fileName: "ducks", iconName: "bird")
    static let earCleaning = AvailableTrack(name: "Ear Cleaning", fileName: "ear-cleaning", iconName: "ear")
    static let fingerCracker = AvailableTrack(name: "Finger Cracker", fileName: "finger-cracker", iconName: "hand.tap")
    static let fireCrackle = AvailableTrack(name: "Fire Crackle", fileName: "fire-and-flame-crackle", iconName: "flame")
    static let fishMoving = AvailableTrack(name: "Fish Moving", fileName: "fish-moving", iconName: "fish")
    static let fizzyDrink = AvailableTrack(name: "Fizzy Drink", fileName: "fizzy-drink", iconName: "wineglass")
    static let flamingos = AvailableTrack(name: "Flamingos", fileName: "flamingos", iconName: "bird")
    static let foamBath = AvailableTrack(name: "Foam Bath", fileName: "foam-bath", iconName: "bathtub")
    static let frogs = AvailableTrack(name: "Frogs", fileName: "Frogs", iconName: "tortoise")
    static let frying = AvailableTrack(name: "Frying", fileName: "frying", iconName: "frying.pan")
    static let greenNoise = AvailableTrack(name: "Green Noise", fileName: "green-noise", iconName: "waveform")
    static let harbourSeagulls = AvailableTrack(name: "Harbour Seagulls", fileName: "Harbour-seagulls", iconName: "bird")
    static let horseTrotting = AvailableTrack(name: "Horse Trotting", fileName: "horse-trotting", iconName: "figure.walk")
    static let iceCubes = AvailableTrack(name: "Ice Cubes", fileName: "ice-cubes", iconName: "square")
    static let iceMelting = AvailableTrack(name: "Ice Melting", fileName: "ice-melting", iconName: "drop.triangle")
    static let icySnow = AvailableTrack(name: "Icy Snow", fileName: "icy-snow", iconName: "snowflake")
    static let lightRain = AvailableTrack(name: "Light Rain", fileName: "light-rain", iconName: "cloud.rain")
    static let makeupBrush = AvailableTrack(name: "Makeup Brush", fileName: "makeup-brush", iconName: "paintpalette")
    static let micScratching = AvailableTrack(name: "Mic Scratching", fileName: "mic-scratching", iconName: "mic")
    static let morningBirdsong = AvailableTrack(name: "Morning Birdsong", fileName: "morning-birdsong", iconName: "bird")
    static let nightSounds = AvailableTrack(name: "Night Sounds", fileName: "night-sounds", iconName: "moon.stars")
    static let owls = AvailableTrack(name: "Owls", fileName: "owls", iconName: "bird")
    static let peepers = AvailableTrack(name: "Peepers", fileName: "peepers", iconName: "tortoise")
    static let rollingThunder = AvailableTrack(name: "Rolling Thunder", fileName: "rolling-thunder", iconName: "cloud.bolt")
    static let scrapingWood = AvailableTrack(name: "Scraping Wood", fileName: "scraping-wood", iconName: "hammer")
    static let seabirds = AvailableTrack(name: "Seabirds", fileName: "Seabirds", iconName: "bird")
    static let sheep = AvailableTrack(name: "Sheep", fileName: "sheep", iconName: "pawprint")
    static let slime = AvailableTrack(name: "Slime", fileName: "slime", iconName: "drop.fill")
    static let storm = AvailableTrack(name: "Storm", fileName: "Storm", iconName: "cloud.bolt.rain")
    static let sunnyDay = AvailableTrack(name: "Sunny Day", fileName: "sunny-day", iconName: "sun.max")
    static let tapWater = AvailableTrack(name: "Tap Water", fileName: "tap-water", iconName: "drop")
    static let thunderStrike = AvailableTrack(name: "Thunder Strike", fileName: "thunder-strike", iconName: "bolt")
    static let thunderStorm = AvailableTrack(name: "Thunderstorm", fileName: "ThunderStorm", iconName: "cloud.bolt.rain")
    static let tinFoil = AvailableTrack(name: "Tin Foil", fileName: "tin-foil", iconName: "square.stack.3d.up")
    static let vinylCrackle = AvailableTrack(name: "Vinyl Crackle", fileName: "vinyl-crackle", iconName: "record.circle")
    static let walkingForest = AvailableTrack(name: "Walking in Forest", fileName: "walking-in-forest", iconName: "figure.walk")
    static let walkingMeltedSnow = AvailableTrack(name: "Walking in Melted Snow", fileName: "Walking-in-Melted-Snow", iconName: "figure.walk")
    static let walkingLeaves = AvailableTrack(name: "Walking on Leaves", fileName: "walking-on-leaves", iconName: "figure.walk")
    static let walkingSnow = AvailableTrack(name: "Walking on Snow", fileName: "walking-on-snow", iconName: "figure.walk")
    static let waterFlowing = AvailableTrack(name: "Water Flowing", fileName: "water-flowing", iconName: "drop")
    static let waterSlushing = AvailableTrack(name: "Water Slushing", fileName: "water-slushing", iconName: "drop")
    static let whale = AvailableTrack(name: "Whale", fileName: "whale", iconName: "fish")
    static let windBlowing = AvailableTrack(name: "Wind Blowing", fileName: "wind-blowing", iconName: "wind")
    static let windEars = AvailableTrack(name: "Wind in Ears", fileName: "wind-in-ears", iconName: "wind")
    static let windTrees = AvailableTrack(name: "Wind through Trees", fileName: "wind-through-trees", iconName: "tree")
    static let winterForest = AvailableTrack(name: "Winter Forest", fileName: "winter-forest", iconName: "tree")
    static let winter = AvailableTrack(name: "Winter", fileName: "Winter", iconName: "snowflake")
    static let wolfHowls = AvailableTrack(name: "Wolf Howls", fileName: "wolf-howls", iconName: "pawprint")
    static let writing = AvailableTrack(name: "Writing", fileName: "writing", iconName: "pencil.tip")

    static let catalog: [AvailableTrack] = [
        arcticWind, autumnForest, bats, beads, bedSheets,
        binaural174, binaural396, binaural417, binaural432, binaural528, binaural639,
        birdsChirping, boilingWater, bookPageTurning, bubbleWrap, bubblingMagma,
        bullfrogs, bumblebee, catPurring, chacalacaBirds, chickens, cowsMoos,
        crickets, cuckooBirds, deepBrownNoise, dryLeaves, ducks, earCleaning,
        fingerCracker, fireCrackle, fishMoving, fizzyDrink, flamingos, foamBath,
        frogs, frying, greenNoise, harbourSeagulls, horseTrotting, iceCubes,
        iceMelting, icySnow, lightRain, makeupBrush, micScratching, morningBirdsong,
        nightSounds, owls, peepers, rollingThunder, scrapingWood, seabirds,
        sheep, slime, storm, sunnyDay, tapWater, thunderStrike, thunderStorm,
        tinFoil, vinylCrackle, walkingForest, walkingMeltedSnow, walkingLeaves,
        walkingSnow, waterFlowing, waterSlushing, whale, windBlowing, windEars,
        windTrees, winterForest, winter, wolfHowls, writing
    ]

    static func manifestTrack(name: String, fileName: String) -> AvailableTrack {
        AvailableTrack(name: name, fileName: fileName, iconName: "music.note")
    }
}
