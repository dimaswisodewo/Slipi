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

                    
                    // LIST
                    LazyVStack(spacing: 10) {
                        
                        CardMusicView(
                            title: "Rainy Day",
                            items: 3,
                            images:["wind","flame","bird"],
                            onClickAction: {}
                        )
                        
                        CardMusicView(
                            title: "Deep Focus",
                            items: 2,
                            images:["wind","bird"],
                            onClickAction: {}
                        )
                        
                        CardMusicView(
                            title: "Calming Wind Blow",
                            items: 1,
                            images:["wind"],
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
