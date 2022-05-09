//
//  SearchSceneInteractor.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import Foundation

protocol SearchSceneBusinessLogic {
    func performSearch(request: SearchScene.PerformSearch.Request)
}

final class SearchSceneInteractor {
    var presenter: SearchScenePresentationLogic?
    var worker: SearchSceneFetchLogic?
}

extension SearchSceneInteractor: SearchSceneBusinessLogic {
    func performSearch(request: SearchScene.PerformSearch.Request) {
        self.worker?.makeSearch(
            apiKey: request.searchSceneFields.apiKey,
            searchInput: request.searchSceneFields.searchInput,
            completion: { result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let movies):
                        self?.presenter?.presentSearchResult(response: SearchScene.PerformSearch.Response(movies: movies))
                    case .failure(let error):
                        self?.presenter?.presentError(error: error.localizedDescription)
                    }
                }
            })
    }
}
