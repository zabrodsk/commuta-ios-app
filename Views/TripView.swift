import SwiftUI
import MapKit

/// View showing details of a selected route and allowing the rider to join.
struct TripView: View {
    var route: Route
    var requestSeats: Int
    @State private var hasJoined: Bool = false
    @State private var region: MKCoordinateRegion

    init(route: Route, requestSeats: Int) {
        self.route = route
        self.requestSeats = requestSeats
        // derive a region based on first waypoint or fallback to Ostrava coordinates
        if let first = route.waypoints.first {
            _region = State(initialValue: MKCoordinateRegion(
                center: first,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 49.8209, longitude: 18.2625),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            ))
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: route.waypoints, annotationContent: { coord in
                MapPin(coordinate: coord)
            })
            .frame(height: 250)
            .cornerRadius(10)
            .padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Driver: \(route.driver.name)")
                    .font(.headline)
                Text("From: \(route.origin)")
                Text("To: \(route.destination)")
                Text("Departing at: \(formatted(date: route.departureTime))")
                Text("Available seats: \(route.seatsAvailable)")
            }
            .padding()

            if hasJoined {
                Text("You have joined this ride.")
                    .foregroundColor(.green)
                    .font(.headline)
            } else {
                Button(action: {
                    joinRide()
                }) {
                    Text("Join Ride")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding([.horizontal, .bottom])
            }
            Spacer()
        }
        .navigationTitle("Trip Details")
    }

    private func joinRide() {
        // simple check: ensure enough seats, mark joined
        if requestSeats <= route.seatsAvailable {
            hasJoined = true
        }
    }

    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(route: MockData.routes.first!, requestSeats: 1)
    }
}
