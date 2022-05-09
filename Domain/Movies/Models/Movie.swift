//
//  Movie.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 07.05.2022.
//

import Foundation

enum MovieType: String, Decodable {
    case series, movie, game
}

protocol MovieProtocol: Decodable {
    var imdbID: String { get }
    var type: MovieType { get }
    var title: String { get }
    var year: String { get }
    var posterURL: URL { get }
}

struct Movie: MovieProtocol {
    let imdbID: String
    let type: MovieType
    let title: String
    let year: String
    let posterURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case imdbID
        case type = "Type"
        case title = "Title"
        case year = "Year"
        case posterURL = "Poster"
    }
}
