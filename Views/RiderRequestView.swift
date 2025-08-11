import SwiftUI

/// View for riders to request a ride and find matches.
struct RiderRequestView: View {
    var user: User

    @State private var origin: String = "Home"
    @State private var destination: String = "SCIS"
    @State private var seats: String = "1"
    @State private var earliest: Date = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var latest: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
    @State private var showMatches: Bool = false
    @State private var matches: [Route] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Ride Details")) {
                    TextField("Origin", text: $origin)
                    TextField("Destination", text: $destination)
                    TextField("Seats", text: $seats)
                        .keyboardType(.numberPad)
                    DatePicker("Earliest", selection: $earliest, displayedComponents: .hourAndMinute)
                    DatePicker("Latest", selection: $latest, displayedComponents: .hourAndMinute)
                    Button("Search for Matches") {
                        findMatches()
                    }
                }

                if !matches.isEmpty {
                    Section(header: Text("Matches")) {
                        ForEach(matches) { route in
                            NavigationLink(destination: TripView(route: route, requestSeats: Int(seats) ?? 1)) {
                                VStack(alignment: .leading) {
                                    Text("\(route.driver.name)'s Route")
                                    Text("Departs at \(formatted(date: route.departureTime))")
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Find a Ride")
        }
    }

    private func findMatches() {
        guard let seatsInt = Int(seats), seatsInt > 0 else { return }
        let interval = DateInterval(start: earliest, end: latest)
        let request = RideRequest(
            id: UUID(),
            rider: user,
            origin: origin,
            destination: destination,
            seatsRequested: seatsInt,
            timeWindow: interval,
            requestedAt: Date()
        )
        matches = MockData.matches(for: request)
    }

    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct RiderRequestView_Previews: PreviewProvider {
    static var previews: some View {
        let rider = MockData.users.first { $0.role == .rider }!
        RiderRequestView(user: rider)
    }
}
