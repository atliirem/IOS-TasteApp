//
//  VerticalListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.


import SwiftUI

struct VerticalListView: View {
    var header = "Popular Meals"
    let meal = [
        Meal(name: "Pizza", image: "pizza", category: "fast food"),
        Meal(name: "Ev yemeği ", image: "home", category: "home made"),
        Meal(name: "Salata", image: "salata", category: "salad"),
        Meal(name: "köfte", image: "water", category: "home made"),
        Meal(name: "Salata", image: "salata", category: "salad"),
        Meal(name: "köfte", image: "water", category: "home made"),
        Meal(name: "Salata", image: "salata", category: "salad"),
        Meal(name: "köfte", image: "water", category: "home made"),
        
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ScrollView(.vertical, showsIndicators: false){
                Text(header)
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color(hex: "#f28a4a"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                LazyVStack{
                    ForEach(meal){
                        
                        meal in
                        MealCard(meal: meal){
                            print(meal.name)
                        }
                    }
                    
                    .padding(.vertical)
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    VerticalListView()
}
