import Foundation
import FirebaseStorage

struct StorageService {
    private let storage = Storage.storage(url: "gs://tasteapp-7449e.firebasestorage.app")

    func uploadMealImage(data: Data, mealID: String) async throws -> String {
        let path = "meal_images/\(mealID).jpg"
        let ref = storage.reference().child(path)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        do {
            print(" Upload başlıyor...")
            let result = try await ref.putDataAsync(data, metadata: metadata)
            print("Upload bitti:", result.size, "bytes")
            
            let url = try await ref.downloadURL()
            print(" URL alındı:", url.absoluteString)
            return url.absoluteString
        } catch {
            print(" HATA:", error.localizedDescription)
            print(" HATA KODU:", (error as NSError).code)
            print(" HATA DETAY:", (error as NSError).userInfo)
            throw error
        }
    }
}
