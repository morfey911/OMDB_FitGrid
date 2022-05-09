//
//  SearchSceneWorker.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import Foundation

protocol SearchSceneFetchLogic {
    func makeSearch(
        apiKey: String,
        searchInput: String,
        completion: @escaping (Result<[MovieProtocol], Error>) -> Void
    )
}

final class SearchSceneWorker {
    private let service: NetworkService
    
    init(service: NetworkService) {
        self.service = service
    }
}

extension SearchSceneWorker: SearchSceneFetchLogic {
    func makeSearch(
        apiKey: String,
        searchInput: String,
        completion: @escaping (Result<[MovieProtocol], Error>) -> Void)
    {
        let request = SearchQueryRequest(apiKey: apiKey, input: searchInput)
        self.service.request(request) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
