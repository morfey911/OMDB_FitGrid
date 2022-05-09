//
//  SearchScenePresenter.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import Foundation

protocol SearchScenePresentationLogic {
    func presentSearchResult(response: SearchScene.PerformSearch.Response)
    func presentError(error: String)
}

final class SearchScenePresenter {
    weak var viewController: SearchSceneDisplayLogic?
}

extension SearchScenePresenter: SearchScenePresentationLogic {
    func presentSearchResult(response: SearchScene.PerformSearch.Response) {
        self.viewController?.displaySearchResult(viewModel: SearchScene.PerformSearch.ViewModel(movies: response.movies))
    }
    
    func presentError(error: String) {
        self.viewController?.displayError(error: error)
    }
}
