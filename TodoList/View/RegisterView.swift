import SwiftUI


struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()

    var body: some View {
        VStack {
            // Header
            HeaderView(title: "Register", subtitle: "Start Organizing Todo", angle: -15, background: .deepGreen)
                .padding(.bottom, 20) // Add spacing below the header
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())

                TDButton(title: "Create Account", background: .green) {
                    viewModel.register()
                }
                .padding()
            }
            .offset(y: -20) // Adjust form position if needed
            
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}
