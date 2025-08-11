import SwiftUI

/// Top level container with tab navigation for drivers and riders.
struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var currentUser: User? = nil

    var body: some View {
        if currentUser == nil {
            // show onboarding/login screen first
            LoginView { user in
                self.currentUser = user
            }
        } else {
            TabView(selection: $selectedTab) {
                RiderRequestView(user: currentUser!)
                    .tabItem {
                        Label("Ride", systemImage: "car")
                    }
                    .tag(0)
                DriverRouteView(user: currentUser!)
                    .tabItem {
                        Label("Drive", systemImage: "steeringwheel")
                    }
                    .tag(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
