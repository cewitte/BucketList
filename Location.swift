//
//  Location.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 27/04/25.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    
}
