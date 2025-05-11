//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 20/04/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            NavigationStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                                    .simultaneousGesture(LongPressGesture(minimumDuration: 1).onEnded { _ in viewModel.selectedPlace = location }) // this is not Paul's original code. It was recommended by YouTube user`s @morderloth1 two months ago as a comment to the video lesson. It was the only way to make it work (at least in the simulator).
                            }
                        }
                    }
                    .ignoresSafeArea(edges: .all)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.hidden, for: .navigationBar)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                viewModel.showHybridMap.toggle()
                            }) {
                                Text(viewModel.showHybridMap ? "hybrid" : "standard")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(minWidth: 80, alignment: .center)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.white.opacity(0.3))
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule().stroke(Color.white, lineWidth: 1.5)
                                    )
                            }
                            
                            
                        }
                    }
                    .mapStyle(viewModel.showHybridMap ? .hybrid : .standard)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
            }
        } else {
            NavigationStack {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
            .alert("Authentication Failed", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.authenticationError)
            }
        }
    }
}

#Preview {
    ContentView()
}
