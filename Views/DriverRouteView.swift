import SwiftUI

/// View allowing drivers to create and manage their routes.
struct DriverRouteView: View {
    var user: User
    @State private var myRoutes: [Route] = []

    // form fields for new route
    @State private var origin: String = ""
    @State private var destination: String = "SCIS"
    @State private var seats: String = "1"
    @State private var departureTime: Date = Calendar.current.date(bySettingHour: 7, minute: 30, second: 0, of: Date()) ?? Date()

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Create Route")) {
                        TextField("Origin", text: $origin)
                        TextField("Destination", text: $destination)
                        TextField("Seats", text: $seats)
                            .keyboardType(.numberPad)
                        DatePicker("Departure", selection: $departureTime, displayedComponents: .hourAndMinute)
                        Button("Add Route") {
                            addRoute()
                        }
                    }
                    Section(header: Text("My Routes")) {
                        if myRoutes.isEmpty {
                            Text("No routes yet. Add one above.")
                        }
                        ForEach(myRoutes) { route in
                            VStack(alignment: .leading) {
                                Text("\(route.origin) → \(route.destination)")
                                    .font(.headline)
                                Text("Seats: \(route.seatsAvailable), Departs at \(formatted(date: route.departureTime))")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Drive")
        }
        .onAppear {
            loadExistingRoutes()
        }
    }

    private func loadExistingRoutes() {
        // load routes where current user is the driver
        myRoutes = MockData.routes.filter { $0.driver.id == user.id }
    }

    private func addRoute() {
        guard let seatsInt = Int(seats), seatsInt > 0 else { return }
        let newRoute = Route(
            id: UUID(),
            driver: user,
            origin: origin.isEmpty ? "Unknown" : origin,
            destination: destination.isEmpty ? "Unknown" : destination,
            seatsAvailable: seatsInt,
            departureTime: departureTime,
            detourTolerance: 1.0,
            waypoints: []
        )
        myRoutes.append(newRoute)
        // reset form
        origin = ""
        destination = "SCIS"
        seats = "1"
    }

    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct DriverRouteView_Previews: PreviewProvider {
    static var previews: some View {
        let driver = MockData.users.first { $0.role == .driver }!
        DriverRouteView(user: driver)
    }
}
