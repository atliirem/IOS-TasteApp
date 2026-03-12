//
//  ProfileView.swift
//  TasteApp
//
//  Created by İrem Atlı on 10.03.2026.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        HStack{
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
           
            VStack(alignment: .leading, spacing: 5){
                Text("Name")
                    .font(.default)
                    .font(.system(size: 14))
                
                Text("@username")
                Text("phone")
                
                

          
                
            }
            Spacer()
        }
        Spacer()
    }
}

#Preview {
    ProfileView()
}
