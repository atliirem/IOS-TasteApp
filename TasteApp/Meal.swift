//
//  Meal.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import Foundation

struct Meal : Identifiable {
    let id = UUID()
    let name : String
    let image: String
    let category:  String
}
