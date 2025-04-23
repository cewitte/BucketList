//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 20/04/25.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    var id: UUID = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501389, longitude: -0.141389)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508333, longitude: -0.076222)),
    ]
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    var body: some View {
        VStack {
            Map()
            
            Spacer()
            
            Map()
                .mapStyle(.imagery)
            
            Spacer()
            
            Map()
                .mapStyle(.hybrid)
            
            Spacer()
            
            VStack {
                Map(position: $position)
                    .mapStyle(.hybrid(elevation: .realistic))
                    .onMapCameraChange(frequency: .continuous) {context in
                        print(context.region)
                    }
                
                HStack(spacing: 50) {
                    Button("Paris") {
                        position = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 3.3522),
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                    }
                    
                    Button("Tokyo") {
                        position = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                        )
                    }
                }
            }
            
            Spacer()
            
            Map(interactionModes: [.rotate, .zoom])
                .mapStyle(.standard)
            
        }
        
        VStack {
            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            print(coordinate)
                        }
                    }
            }
            Map {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Text(location.name)
                            .font(.headline)
                            .padding()
                            .background(.blue.gradient)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                    .annotationTitles(.hidden)
                    
                }
                
            }
        }
    }
    
}


#Preview {
    ContentView()
}
