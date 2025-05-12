//
//  EditView.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 28/04/25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
//    var location: Location
//    
//    @State private var name: String
//    @State private var description: String
    
    @State private var viewModel : ViewModel
    
    var onSave: (Location) -> Void
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @State private var loadingState: LoadingState = .loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby…") {
                    switch loadingState {
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(viewModel.location.latitude)%7C\(viewModel.location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
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
    
    // the @escaping part is important, and means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = State(initialValue: .init(
            name: location.name,
            description: location.description,
            location: location
        ))
        
        
//        _viewModel.location = location
        self.onSave = onSave
        
//        name = State(initialValue: location.name)
//        description = State(initialValue: location.description)
    }
}

#Preview {
    // just passing in a placeholder closure is fine here
    EditView(location: .example) { _ in }
}
