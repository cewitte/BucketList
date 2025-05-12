//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 11/05/25.
//

import Foundation

extension EditView {
    
    @Observable
    class ViewModel {
        var name: String
        var description: String
        var location: Location
        
        init (name: String, description: String, location: Location) {
            self.name = name
            self.description = description
            self.location = location
        }
        
        
    }
}
