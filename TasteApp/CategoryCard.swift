import SwiftUI

struct CategoryCard: View {
    
    let category: Category
    var onTap: () -> Void
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            
//            Image(systemName:  "carrot.fill" )
//                .frame(width: 40, height:  40)
//            //    .padding(.bottom, 20)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//                )
                 
            Text(category.name)
                .font(.caption)
        }
        .frame(width: 60)
        .onTapGesture {
            onTap()
        }
    }
}
