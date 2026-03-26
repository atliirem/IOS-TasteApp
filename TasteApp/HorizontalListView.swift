//
//  HorizontalListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI

struct HorizontalListView: View {
    var header =  "Categories"
    var selectedCategory:  String?
    
    let categories  = [
        
        Category(name: "Dessert" , image: "des"),
        Category(name: "Vegetarian" , image: "vega"),
        Category(name: "Pasta" , image: "pasta"),
        Category(name: "Beef" , image: "beef"),
        Category(name: "Side" , image: "side"),
        Category(name: "Seafood" , image: "seafood"),
        Category(name: "Chicken" , image: "chicken"),
        Category(name: "Miscellaneous" , image: "ot"),
        
    ]
    var onCategorySelected : (Category) -> Void
    
    
    var body: some View {
        VStack(alignment:  .leading, spacing: 10) {
            Text(header)
                .font(.title3)
                .bold()
                .foregroundColor(Color(hex: "#f28a4a"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
                
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(categories) {  category in
                        CategoryCard(
                            category: category,
                            isSelected: selectedCategory == category.name
                        ) {
                            onCategorySelected(category)
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
            }
        }
    }
}

#Preview {
    HorizontalListView(
        header: "Categories",
        selectedCategory: "Dessert",
        onCategorySelected: { _ in }
    )
}
