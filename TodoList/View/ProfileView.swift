import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = viewModel.user {
                    ProfileInfo(user: user, viewModel: viewModel)
                } else {
                    ProgressView("Loading profile...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                        .padding()
                }
            }
            .navigationTitle("Profile")
            .onAppear {
                Task {
                    await viewModel.fetchUser()
                }
            }
            .fullScreenCover(isPresented: $viewModel.isLoggedOut) {
                LoginView() // Navigate to LoginView after logout
            }
        }
    }
}

struct ProfileInfo: View {
    let user: User
    @ObservedObject var viewModel: ProfileViewViewModel // Pass viewModel to access logOut()
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .frame(width: 125, height: 125)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Name:")
                        .bold()
                    Text(user.name)
                }
                HStack {
                    Text("Email:")
                        .bold()
                    Text(user.email)
                }
                HStack {
                    Text("Member Since:")
                        .bold()
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Button("Log Out") {
                viewModel.logOut()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView()
}
