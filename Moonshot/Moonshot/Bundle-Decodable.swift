//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Natalie Alvarez on 3/25/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        // Find the file:
        guard let url = self.url(forResource: file, withExtension: mil) {
            fatalError("Failed to locate \(file) in bundle.")
        }

        // Load the file data:
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        // Decode the data into a [String: any Type] dictionary:
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
