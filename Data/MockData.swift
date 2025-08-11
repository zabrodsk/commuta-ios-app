import Foundation
import CoreLocation

/// Simple static mocks used for prototyping.  In production this
/// data would be fetched from a backend.
enum MockData {
    static let users: [User] = {
        let alice = User(id: UUID(), name: "Alice", role: .driver)
        let bob = User(id: UUID(), name: "Bob", role: .rider)
        let charlie = User(id: UUID(), name: "Charlie", role: .driver)
        return [alice, bob, charlie]
    }()

    static let routes: [Route] = {
        // create example waypoints around Ostrava for demonstration only
        let waypoints1: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 49.8209, longitude: 18.2625), // home
            CLLocationCoordinate2D(latitude: 49.7791, longitude: 18.2190), // school
        ]
        let waypoints2: [CLLocationCoordinate2D] = [
            CLLocationCoordinate2D(latitude: 49.8209, longitude: 18.2625),
            CLLocationCoordinate2D(latitude: 49.8026, longitude: 18.2334),
            CLLocationCoordinate2D(latitude: 49.7791, longitude: 18.2190),
        ]
        let driver1 = users.first { $0.name == "Alice" }!
        let driver2 = users.first { $0.name == "Charlie" }!

        return [
            Route(
                id: UUID(),
                driver: driver1,
                origin: "Alice's Home",
                destination: "SCIS",
                seatsAvailable: 2,
                departureTime: Calendar.current.date(bySettingHour: 7, minute: 15, second: 0, of: Date()) ?? Date(),
                detourTolerance: 1.0,
                waypoints: waypoints1
            ),
            Route(
                id: UUID(),
                driver: driver2,
                origin: "Charlie's Home",
                destination: "SCIS",
                seatsAvailable: 3,
                departureTime: Calendar.current.date(bySettingHour: 7, minute: 30, second: 0, of: Date()) ?? Date(),
                detourTolerance: 2.0,
                waypoints: waypoints2
            )
        ]
    }()

    /// Very naive matching: returns routes where destination matches and seats are sufficient.
    static func matches(for request: RideRequest) -> [Route] {
        routes.filter { route in
            route.destination.lowercased() == request.destination.lowercased() &&
            route.seatsAvailable >= request.seatsRequested
        }.sorted(by: { $0.departureTime < $1.departureTime })
    }
}
