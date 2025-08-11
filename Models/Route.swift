import Foundation
import CoreLocation

/// Represents a driver's recurring or one time route.
struct Route: Identifiable, Hashable {
    let id: UUID
    var driver: User
    var origin: String
    var destination: String
    var seatsAvailable: Int
    var departureTime: Date
    var detourTolerance: Double // maximum additional distance (km) willing to deviate

    /// Simplified polyline representation for matching.  In a real implementation this would
    /// be a sequence of coordinates or a polyline string.
    var waypoints: [CLLocationCoordinate2D]
}
