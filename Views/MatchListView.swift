import SwiftUI

/// Shows a list of matching routes for a given request.  Not currently used in the prototype but available for future expansion.
struct MatchListView: View {
    let matches: [Route]
    let seatsRequested: Int

    var body: some View {
        List(matches) { route in
            NavigationLink(destination: TripView(route: route, requestSeats: seatsRequested)) {
                VStack(alignment: .leading) {
                    Text("Driver: \(route.driver.name)")
                    Text("Departs at \(formatted(date: route.departureTime))")
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle("Matches")
    }

    private func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct MatchListView_Previews: PreviewProvider {
    static var previews: some View {
        MatchListView(matches: MockData.routes, seatsRequested: 1)
    }
}
