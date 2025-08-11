# Commuta iOS App (Prototype)

This repository contains a minimal SwiftUI prototype for **Commuta**, a community‑powered ride sharing app.

> **Note**: This project is intended as a starting point for an iOS application and demonstrates core concepts of routing, ride requests, matching and trip tracking. It does **not** implement all planned features described in the product plan and does not connect to a real backend. Feel free to extend and iterate on this codebase for production use.

## Key Ideas

- **Community ride sharing**: riders and drivers within a private circle (for example, a school) share real‑time routes and request seats in available cars.
- **Driver flow**: drivers create recurring routes, define seat availability and start trips when departing.
- **Rider flow**: riders request rides by selecting origin and destination, then choose from available matches.
- **Matching**: a simple in‑memory matcher scores drivers based on route overlap and returns a sorted list of potential rides.  In a production app this logic would run server‑side.
- **Trip tracking**: when a ride is accepted the app displays the route, live driver position and basic safety info.

## Folder Structure

```
commuta-ios-app/
├── README.md                    – project overview (this file)
├── CommutaAppApp.swift          – entry point for the SwiftUI app
├── Models/
│   ├── User.swift               – basic user model
│   ├── Route.swift              – driver route definition
│   └── RideRequest.swift        – ride request model
├── Data/
│   └── MockData.swift           – simple in‑memory data for drivers and riders
├── Views/
│   ├── LoginView.swift          – placeholder login/onboarding flow
│   ├── DriverRouteView.swift    – create and publish driver routes
│   ├── RiderRequestView.swift   – request a ride and view matches
│   ├── MatchListView.swift      – list matching routes
│   └── TripView.swift           – show active trip
└── ContentView.swift            – top level tabbed navigation
```

## Requirements

This project uses **SwiftUI** and targets iOS 17+. To run it in Xcode:

1. Open Xcode and create a new iOS project using the *App* template.
2. Delete the default `ContentView.swift` and replace it with the files in this directory.
3. Add the contents of `commuta-ios-app` into the project navigation and ensure the files are included in the build target.
4. Build and run on an iOS simulator or device.

## License

This prototype is provided under the MIT License. See `LICENSE` for details.
