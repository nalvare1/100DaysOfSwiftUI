//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/8/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)

                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }

    func loadData() async {
        // Get the URL:
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }


        do {
            // Get the data from the URL:
            let (data, _) = try await URLSession.shared.data(from: url) // returns a tuple containing the data found at that URL (and also metadata about the request itself, which is discarded as "_")

            // Decode the data:
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
