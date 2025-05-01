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

### Selecting and editing map annotations

Source URL: [Selecting and editing map annotations](https://www.hackingwithswift.com/books/ios-swiftui/selecting-and-editing-map-annotations)

Paul shows a lot of new techniques in this part, which I'll try to summarize below:

#### Sometimes, you can present a view based on an optional binding, like here:

```swift
@State private var selectedPlace: Location?

.sheet(item: $selectedPlace) { place in
    Text(place.name)
}
```
This can be very handy indeed. It basically means: _show this view only when `selectedPlace` has a value_, or in Swift terms: Swift unbinds it for us.

#### We can use the same underscore approach we used when creating a SwiftData query inside an initializer, which allows us to create an instance of the property wrapper not the data inside the wrapper:

```swift
@State private var name: String
@State private var description: String

init(location: Location) {
    self.location = location

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
}
```

#### We can require a function to call where we can pass back whatever data (in this case, a new location) we want. This means any other SwiftUI can send us some data, and get back some new data to process however we want:

```swift
var onSave: (Location) -> Void

init(location: Location, onSave: @escaping (Location) -> Void) {
    self.location = location
    self.onSave = onSave

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
}
```

"That `@escaping` part is important, and means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save."

#### We can update Preview by using a placeholder closure

```swift
EditView(location: .example) { _ in }
```

#### Finally, we can pass in a closure to run when a data change occurs in the child view (when the Save button is pressed) 

```swift
EditView(location: place) { newLocation in
    if let index = locations.firstIndex(of: place) {
        locations[index] = newLocation
    }
}
```

"That accepts the new location, then looks up where the current location is and replaces it in the array. This will cause our map to update immediately with the new data."

Here's the product of this commit: 

![Selecting and editing maps](/images/selecting_editing_maps.gif)

#### One last thing (for `LongPressGesture`)

I double checked, and Paul's code doesn't seem to work for me (could it be an XCode/iOS version issue?). When I long press in the simulator, nothing happens. It seems one of Paul's students figured out the solution to the problem:

```swift
.onLongPressGesture {
    selectedPlace = location
}
.simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in selectedPlace = location }) // this is not Paul's original code. It was recommended by YouTube user`s @morderloth1 two months ago as a comment to the video lesson. It was the only way to make it work (at least in the simulator).
```

The `simultaneousGesture`made it work for me and apparently for other students as well.

### Acknowledgments

Original code created by: [Paul Hudson - @twostraws](https://x.com/twostraws) (Thank you!)

Made with :heart: by [@cewitte](https://x.com/cewitte)
