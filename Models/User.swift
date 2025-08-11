import Foundation

/// Basic representation of a user in the app.  For the prototype
/// we include only a subset of fields; production should extend this model
/// with authentication identifiers, verification status, vehicle information, etc.
struct User: Identifiable, Hashable {
    let id: UUID
    var name: String
    var role: Role

    enum Role: String, CaseIterable, Identifiable {
        case driver
        case rider

        var id: String { rawValue }
    }
}
