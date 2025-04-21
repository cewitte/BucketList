//
//  ContentView.swift
//  BucketList
//
//  Created by Carlos Eduardo Witte on 20/04/25.
//

import SwiftUI

struct ContentView: View {
   
    @State private var retrievedData: String?
    
    var body: some View {
        Button("Read and Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url)
                let readData = try Data(contentsOf: url)
                print(String(data: readData, encoding: .utf8) ?? "Could not read data")
                retrievedData = String(data: readData, encoding: .utf8)
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
        
        Text(retrievedData ?? "No data retrieved")
    }
}

#Preview {
    ContentView()
}
