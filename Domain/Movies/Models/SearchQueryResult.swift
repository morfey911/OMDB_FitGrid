//
//  SearchQuery.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 07.05.2022.
//

import Foundation

protocol SearchQueryProtocol: Decodable {
    var search: [Movie] { get }
    var totalResults: Int { get }
    var response: Bool { get }
}

struct SearchQueryResult: SearchQueryProtocol {
    let search: [Movie]
    let totalResults: Int
    let response: Bool
    
    private enum CodingKeys: String, CodingKey {
        case totalResults
        case search = "Search"
        case response = "Response"
    }
}

extension SearchQueryResult: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalResults = Int(try container.decode(String.self, forKey: .totalResults)) ?? 0
        self.response = try container.decode(String.self, forKey: .response) == "True" ? true : false
        self.search = try container.decode(Array.self, forKey: .search)
    }
}
