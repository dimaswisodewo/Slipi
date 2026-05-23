//
//  FavoritesRemixView.swift
//  Slipi
//
//  Created by Muhammad Syukron Jazila on 23/05/26.
//

import SwiftUI

struct FavoritesRemixView: View {
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: .orange, location: 0.0),
                .init(color: .black, location: 0.35),
            ], startPoint: .topLeading, endPoint: .bottomTrailing)

            
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

                    
                    // LIST
                    LazyVStack(spacing: 10) {
                        
                        CardMusicView(
                            title: "Rainy Day",
                            items: 3,
                            images:["windIcon","flameIcon","birdIcon"],
                            onClickAction: {}
                        )
                        
                        CardMusicView(
                            title: "Deep Focus",
                            items: 2,
                            images:["windIcon", "birdIcon"],
                            onClickAction: {}
                        )
                        
                        CardMusicView(
                            title: "Calming Wind Blow",
                            items: 1,
                            images:["windIcon"],
                            onClickAction: {}
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
     
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FavoritesRemixView()
}
