import SwiftUI


struct SignUpView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State var git = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
              
                Image("logo2")
                    .resizable()
                    .scaledToFit()
                
                
                Text("Sign Up")
                    .font(.title2)
                    .bold()
                
                
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                
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
                        await authViewModel.signUp(email: email, password: password, username: username)
                    }
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(12)
                }
                Text("Already you have a account?")
                    .foregroundStyle(.orange)
                    .font(.subheadline)
                    .bold()
                    .onTapGesture{
                        git = true
                    }
                    .navigationDestination(isPresented: $git) {
                        LoginView(authViewModel: authViewModel)
                    }
                
                if !authViewModel.errorMessage.isEmpty {
                    Text(authViewModel.errorMessage)
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}
#Preview {
    SignUpView(authViewModel: AuthViewModel())
}
