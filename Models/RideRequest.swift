import Foundation
import CoreLocation

/// Represents a rider's request for a seat from origin to destination.
struct RideRequest: Identifiable, Hashable {
    let id: UUID
    var rider: User
    var origin: String
    var destination: String
    var seatsRequested: Int
    var timeWindow: DateInterval
    var requestedAt: Date
}
