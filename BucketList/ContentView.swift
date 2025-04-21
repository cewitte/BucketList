//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 20/04/25.
//

import SwiftUI

struct User: Identifiable, Comparable {
    var id: UUID
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.firstName < rhs.firstName
    }
}

struct ContentView: View {
    let users = [
        User(id: UUID(), firstName: "Carlos", lastName: "Eduardo"),
        User(id: UUID(), firstName: "João", lastName: "Silva"),
        User(id: UUID(), firstName: "Maria", lastName: "José"),
        User(id: UUID(), firstName: "Amanda", lastName: "Rocks"),
        User(id: UUID(), firstName: "Valéria", lastName: "Twists"),
    ].sorted()
    
    var body: some View {
        VStack {
            ForEach(users) { user in
                Text(user.firstName + " " + user.lastName)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
