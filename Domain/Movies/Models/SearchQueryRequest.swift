//
//  SearchQueryRequest.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 07.05.2022.
//

import Foundation

struct SearchQueryRequest: DataRequest {
    var url: String {
        return "http://www.omdbapi.com/"
    }
    
    let queryItems: [String : String]
    
    var method: HTTPMethod {
        .get
    }
    
    init(apiKey: String, input: String) {
        self.queryItems = [
            "apiKey": apiKey,
            "s": input
        ]
    }
    
    func decode(_ data: Data) throws -> [MovieProtocol] {
        let result = try JSONDecoder().decode(SearchQueryResult.self, from: data)
        return result.search
    }
}
