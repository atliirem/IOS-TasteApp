//
//  ContentView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constant.homeString, systemImage: Constant.homeIconString){
                HomeView()
            }
            Tab(Constant.myList, systemImage: Constant.myListIconString){
               MyListView()
            }
            Tab(Constant.profileString, systemImage: Constant.profileIconString){
                ProfileView()
            }
            }
    }
}
#Preview {
    ContentView()
}
