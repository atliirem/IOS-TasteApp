//
//  VerticalListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.


import SwiftUI

struct VerticalListView: View {
    var header = "Popular Meals"
    let meals: [Meal]
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
                        MealCard(meal: meal){
                            print(meal.name)
                        }
                    }
                    
                    .padding(7)
                
                }
            }
        }
    }
}

#Preview {
    VerticalListView(
           header: "Meals",
           meals: [
               Meal(name: "Pizza", image: "pizza", category: "Fast Food"),
               Meal(name: "Salata", image: "salata", category: "Salad"),
               Meal(name: "Burger", image: "burger", category: "Fast Food")
           ]
       )
}
