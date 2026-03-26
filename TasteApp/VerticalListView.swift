//
//  VerticalListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.


import SwiftUI

struct VerticalListView: View {
    var header = "Favorite Meals"
    let meals: [Meal]
    
    let favoriteIDs: Set<String>
    var onFavoriteToggle: (Meal) -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ScrollView(.vertical, showsIndicators: false){
                Text(header)
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(hex: "#f28a4a"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                LazyVStack{
                    ForEach (meals) {
                        meal in
                        NavigationLink(
                            destination: MealDetailView(
                                meal: meal,
                                isFavorite: favoriteIDs.contains(meal.id),
                                onFavoriteToggle: {
                                    onFavoriteToggle(meal)
                                }
                            )
                        ) {
                            MealCard(meal: meal)
                        }
                    }
                    
                    .padding(7)
                
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        VerticalListView(
            header: "Popular Meals",
            meals: [
                Meal(
                    id: "1",
                    name: "Pizza",
                    image: "https://via.placeholder.com/150",
                    category: "Fast Food",
                    instructions: "Bake it",
                    area: "Italian",
                    tags: "Cheese"
                )
            ],
            favoriteIDs: [],
            onFavoriteToggle: { _ in }
        )
    }
}
