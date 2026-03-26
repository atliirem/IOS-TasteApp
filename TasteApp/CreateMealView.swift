import SwiftUI
import FirebaseAuth
import PhotosUI

struct CreateMealView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var category = ""
    @State private var area = ""
    @State private var instructions = ""
    @State private var ingredient = ""
    @State private var errorMessage = ""
    @State private var isSaving = false
    @State private var tags = ""

    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var selectedUIImage: UIImage?

    private let mealService = MealService()
    private let storageService = StorageService()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                TextField("Meal name", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                TextField("Category", text: $category)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                TextField("Area", text: $area)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                TextField("Ingredients", text: $ingredient, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .lineLimit(3...6)

                PhotosPicker(selection: $selectedItem, matching: .images) {
                    HStack {
                        Image(systemName: "photo")
                        Text("Select Photo")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(12)
                }

                if let selectedUIImage {
                    Image(uiImage: selectedUIImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(12)
                }

                TextField("Instructions", text: $instructions, axis: .vertical)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .lineLimit(6...10)
                
                TextField("Tags (optional)", text: $tags)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)

                Button {
                    Task { await saveMeal() }
                } label: {
                    Text(isSaving ? "Saving..." : "Create Meal")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                .disabled(isSaving)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .onChange(of: selectedItem) { _, newItem in
            Task {
                guard let newItem else { return }
                do {
                    if let data = try await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data),
                       let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                        selectedUIImage = uiImage
                        selectedImageData = jpegData
                    } else {
                        errorMessage = "Selected image could not be converted."
                    }
                } catch {
                    errorMessage = "Image load failed: \(error.localizedDescription)"
                }
            }
        }
    }

    private func saveMeal() async {
        guard Auth.auth().currentUser != nil else {
            errorMessage = "No logged in user."
            return
        }
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !instructions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please fill required fields."
            return
        }
        guard let imageData = selectedImageData, !imageData.isEmpty else {
            errorMessage = "Please select a valid photo."
            return
        }

        let mealID = UUID().uuidString

        do {
            isSaving = true
            errorMessage = ""
            let imageURL = try await storageService.uploadMealImage(data: imageData, mealID: mealID)
            let meal = UserMeal(
                id: mealID,
                name: name,
                category: category,
                image: imageURL,
                instructions: instructions,
                ingredient: ingredient,
                area: area,
                tags: tags.isEmpty ? nil : tags
            )
            try await mealService.createMeal(meal)
            isSaving = false
            dismiss()
        } catch {
            isSaving = false
            errorMessage = error.localizedDescription
        }
    }
}
