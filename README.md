# Bucket List: Introduction

Paul Hudson's ([@twostraws](https://x.com/twostraws)) 100 Days of Swift UI Project 14.

## Project 14

Source URL: [Bucket List: Introduction](https://www.hackingwithswift.com/books/ios-swiftui/bucket-list-introduction)

"In this project we’re going to build an app that lets the user build a private list of places on the map that they intend to visit one day, add a description for that place, look up interesting places that are nearby, and save it all to the iOS storage for later.

To make all that work will mean leveraging some skills you’ve met already, such as forms, sheets, `Codable`, and `URLSession`, but also teach you some new skills: how to embed maps in a SwiftUI app, how to store private data safely so that only an authenticated user can access it, how to load and save data outside of `UserDefaults`, and more."

### Adding conformance to Comparable for custom types

Source URL: [Adding conformance to Comparable for custom types](https://www.hackingwithswift.com/books/ios-swiftui/adding-conformance-to-comparable-for-custom-types)

Branch: `01-comparable`

"Arrays of integers get a simple `sorted()` method with no parameters because Swift understands how to compare two integers. In coding terms, Int conforms to the `Comparable` protocol, which means it defines a function that takes two integers and returns true if the first should be sorted before the second.

We can make our own types conform to `Comparable`, and when we do so we also get a `sorted()` method with no parameters. This takes two steps:

1. Add the `Comparable` conformance to the definition of `User`.
2. Add a method called `<` that takes two users and returns true if the first should be sorted before the second."

Here's how it looks:

```
struct User: Identifiable, Comparable {
    var id: UUID
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}
```

Once you implement `<` _(operator overloading)_, you get the `sorted()` functionality like below:

```
let users = [
        User(id: UUID(), firstName: "Carlos", lastName: "Eduardo"),
        User(id: UUID(), firstName: "João", lastName: "Silva"),
        User(id: UUID(), firstName: "Maria", lastName: "José"),
        User(id: UUID(), firstName: "Amanda", lastName: "Rocks"),
        User(id: UUID(), firstName: "Valéria", lastName: "Twists"),
].sorted()
```