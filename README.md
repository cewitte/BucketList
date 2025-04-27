# Bucket List: Introduction

Paul Hudson's ([@twostraws](https://x.com/twostraws)) 100 Days of Swift UI Project 14.

## Project 14

Source URL: [Bucket List: Introduction](https://www.hackingwithswift.com/books/ios-swiftui/bucket-list-introduction)

"In this project we’re going to build an app that lets the user build a private list of places on the map that they intend to visit one day, add a description for that place, look up interesting places that are nearby, and save it all to the iOS storage for later.

To make all that work will mean leveraging some skills you’ve met already, such as forms, sheets, `Codable`, and `URLSession`, but also teach you some new skills: how to embed maps in a SwiftUI app, how to store private data safely so that only an authenticated user can access it, how to load and save data outside of `UserDefaults`, and more."

### Adding user locations to a map

Source URL: [Adding user locations to a map](https://www.hackingwithswift.com/books/ios-swiftui/adding-user-locations-to-a-map)

"This project is going to be based around a map view, asking users to add places to the map that they want to visit. To do that we need to place a `Map` so that it takes up our whole view, track its annotations, and also whether or not the user is viewing place details.

We’re going to start with a full-screen `Map` view, giving it an initial position."

### Improving our map annotations

Source URL: [Improving our map annotations](https://www.hackingwithswift.com/books/ios-swiftui/improving-our-map-annotations)

In this commit, we are replacing our Marker with an Annotation, which allows us to add a custom View (in our example, a red star) instead of Apple's standard marker.

We are also moving some code from the View to a more proper place: the `Location` struct, by adding a computed property that gives us the coordinate.

Then, we create an example for debugging purposes, which will not be in the final release since we've wrapped it in the `#if debug` and `#endif` code annotation as below:

```swift
#if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "The official residence of the British monarch.", latitude: 51.5074, longitude: -0.1278 )
#endif
```

Finally, we create an operator override to comply with the `Equatable` protocol as below:

```swift
static func ==(lhs: Location, rhs: Location) -> Bool {
    lhs.id == rhs.id
}
```

"I’m a huge fan of making structs conform to Equatable as standard, even if you can’t use an optimized comparison function like above – structs are simple values like strings and integers, and I think we should extend that same status to our own custom structs too."

### Acknowledgments

Original code created by: [Paul Hudson - @twostraws](https://x.com/twostraws) (Thank you!)

Made with :heart: by [@cewitte](https://x.com/cewitte)
