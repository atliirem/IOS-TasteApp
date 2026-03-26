import SwiftUI

struct LoginView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var git = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                
                
                Text("Login")
                    .font(.title)
                    .bold()
                
                
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
                Button {
                    Task {
                        await authViewModel.signIn(email: email, password: password)
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                Text("Don't have an account? Sign up")
                    .foregroundStyle(.orange)
                    .font(.subheadline)
                    .bold()
                    .onTapGesture( ){
                        git = true
                    }.navigationDestination(isPresented: $git){
                        SignUpView(authViewModel: authViewModel)
                    }
                
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}
