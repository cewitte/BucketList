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
        var loadingState: LoadingState = .loading
        var pages = [Page]()
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        init (name: String, description: String, location: Location) {
            self.name = name
            self.description = description
            self.location = location
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // we got some data back
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                // success - convert the array values into our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
                
            } catch {
                loadingState = .failed
            }
        }
    }
}
