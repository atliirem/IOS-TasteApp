//
//  HorizontalListView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI

struct HorizontalListView: View {
    var header =  "Categories"
    let categories  = [
        Category(name: "Salad" , image: "salad"),
        Category(name: "home made" , image: "water"),
        Category(name: "fast food" , image: "fastfood"),
        Category(name: "dessert" , image: "dessert"),
    ]
    
    
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
                    ForEach(categories) {
                        category in
                        CategoryCard(category: category){
                            print("Selected Category: " , category.name)
                        }
                        
                    }
                    .padding(.horizontal)
                }
                
            }
        }
    }
}

