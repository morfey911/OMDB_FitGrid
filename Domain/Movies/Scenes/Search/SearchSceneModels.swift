//
//  SearchSceneModels.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import Foundation

enum SearchScene {
    struct SearchSceneFields {
        var apiKey: String
        var searchInput: String
    }
    
    enum PerformSearch {
        struct Request {
            var searchSceneFields: SearchSceneFields
        }
        struct Response {
            var movies: [MovieProtocol]
        }
        struct ViewModel {
            var movies: [MovieProtocol]
        }
    }
}
