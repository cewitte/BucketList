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

### Writing data to the documents directory

Source URL: [Writing data to the documents directory](https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory)

Branch: `02-writing-to-documents-directory`

"Previously we looked at how to read and write data to `UserDefaults`, which works great for user settings or small amounts of JSON, and we also looked at SwiftData, which is a great choice for times when you want relationships between objects, or more advanced sorting and filtering.

In this app we’re going to look at a middle ground: we'll just write our data to a file directly. This isn't because I hate SwiftData, and in fact I think SwiftData would make a good choice here. Instead, it's so that I can show you the full spread of what's possible in iOS development, because there are lots of apps you'll work on that use exactly this approach to saving their data – it's good that you can at least see how it works.

That being said, using `UserDefaults` is definitely a bad idea here, because there's no limit to how much data users can create in the app. `UserDefaults` is better used for simple settings and similar.

Fortunately, iOS makes it very easy to read and write data from device storage, and in fact all apps get a directory for storing any kind of documents we want. Files here are automatically synchronized with iCloud backups, so if the user gets a new device then our data will be restored along with all the other system data – we don’t even need to think about it.

There is a small catch – isn’t there always? – and it’s that all iOS apps are sandboxed, which means they run in their own container with a hard to guess directory name. As a result, we can’t – and shouldn’t try to – guess the directory where our app is installed, and instead need to rely on a special URL that points to our app’s documents directory:"

```
Button("Read and Write") {
    let data = Data("Test Message".utf8)
    let url = URL.documentsDirectory.appending(path: "message.txt")

    do {
        try data.write(to: url, options: [.atomic, .completeFileProtection])
        let input = try String(contentsOf: url)
        print(input)
    } catch {
        print(error.localizedDescription)
    }
}
```