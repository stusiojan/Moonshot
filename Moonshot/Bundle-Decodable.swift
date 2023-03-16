//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Jan Stusio on 14/03/2023.
//

import Foundation
///generics
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {//<T> by convention means Type
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        //formatter.timeZone tutaj jest odczytywana data w tej samej strefie czasowej, wiec OK, ale norczesciej nalezy sprecyzowac, bo bedzie w strefie czasowej uzytkownika
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {//T.self decode from the json we gave
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
