//
//  MyListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI

struct MyListView: View {
    let meals: [Meal]
    let favoriteIDs: Set<String>
    var onFavoriteToggle: (Meal) -> Void
    
    var favoriteMeals : [Meal] {
        meals.filter {
            favoriteIDs.contains($0.id)
        }
    }
    var body: some View {
        NavigationStack{
            if favoriteMeals.isEmpty {
                Text("no favorite yet")
                    .foregroundStyle(.gray)
            }else{
                VerticalListView(meals: favoriteMeals, favoriteIDs: favoriteIDs, onFavoriteToggle: { _ in} )
            }
        }
    }
}

