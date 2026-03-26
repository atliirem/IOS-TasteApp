import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var errorMessage: String = ""
    
    init() {
        self.user = Auth.auth().currentUser
    }
    func signUp(email: String, password: String, username: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password,)
            
            let changeRequest = result.user.createProfileChangeRequest()
            changeRequest.displayName = username
            try await changeRequest.commitChanges()
            
            self.user = result.user
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password,)
            self.user = result.user
            self.errorMessage = ""
            print("LOGIN SUCCESS:", result.user.email ?? "no email")
        } catch {
            self.errorMessage = error.localizedDescription
            print("LOGIN ERROR:", error.localizedDescription)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.errorMessage = ""
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
