import SwiftUI
struct CategoryCard: View {
    
    let category: Category
    let isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            Image(category.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Text(category.name)
                .font(.system(size: 12))
        }
        .frame(width: 75)
        .padding(.vertical, 8)
        .background(isSelected ? Color.orange.opacity(0.12) : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(isSelected ? Color.black : Color.clear, lineWidth: isSelected ? 2 : 0)
        )
        .onTapGesture {
            onTap()
        }
    }
}
