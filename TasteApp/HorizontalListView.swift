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
        
        Category(name: "Salad" , image: "salad"),
        Category(name: "Home Made" , image: "water"),
        Category(name: "Fast Food" , image: "fastfood"),
        Category(name: "Dessert" , image: "dessert"),
        Category(name: "Salad" , image: "salad"),
        Category(name: "Home Made" , image: "water"),
        Category(name: "Fast Food" , image: "fastfood"),
        Category(name: "Dessert" , image: "dessert"),
        
    ]
    var onCategorySelected : (Category) -> Void
    
    
    var body: some View {
        VStack(alignment:  .leading, spacing: 10) {
            Text(header)
                .font(.title3)
                .bold()
                .foregroundColor(Color(hex: "#f28a4a"))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 15)
                
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
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

