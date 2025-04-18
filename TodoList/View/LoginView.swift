import SwiftUI


extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

    // Define deepTeal color
    static let deepTeal = Color(hex: "#137694")
    static let deepGreen = Color(hex: "#107d65")
}


struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "To Do List", subtitle: "Get Things Done", angle: 15, background: .deepTeal)

                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())

                    TDButton(title: "Log In", background: .teal) {
                        viewModel.login()
                    }
                    .padding()
                }
                .offset(y: -50)

                // Create Account
                VStack {
                    Text("New Around Here?")
                    NavigationLink("Create an Account", destination: RegisterView())
                }
                .padding(.bottom, 50)

                Spacer()
            }
        }
    }
}


#Preview {
    LoginView()
}
