import SwiftUI

/// A very simple login/onboarding view for the prototype.
/// Users select their role (driver or rider) and choose a name from the mock data.
struct LoginView: View {
    var onLogin: (User) -> Void
    @State private var selectedRole: User.Role = .rider
    @State private var selectedNameIndex: Int = 0

    private var availableUsers: [User] {
        MockData.users.filter { $0.role == selectedRole }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Welcome to Commuta")
                    .font(.largeTitle)
                    .padding(.top, 40)

                Picker("Role", selection: $selectedRole) {
                    ForEach(User.Role.allCases) { role in
                        Text(role.rawValue.capitalized).tag(role)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Select User", selection: $selectedNameIndex) {
                    ForEach(availableUsers.indices, id: \ .self) { index in
                        Text(availableUsers[index].name).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 120)

                Button(action: {
                    let chosen = availableUsers[selectedNameIndex]
                    onLogin(chosen)
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView { _ in }
    }
}
