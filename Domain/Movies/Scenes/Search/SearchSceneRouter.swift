//
//  SearchRouter.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import UIKit

protocol SearchSceneRoutingLogic {
    func routeToShowMovies(data: [MovieProtocol])
    func routeToShowSearchFailure(message: String)
}

final class SearchSceneRouter {
    weak var source: UIViewController?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

extension SearchSceneRouter: SearchSceneRoutingLogic {
    func routeToShowMovies(data: [MovieProtocol]) {
        let scene = self.sceneFactory.makeSearchResultScene() as! ResultsSceneViewController
        var destinationDS = scene.router!.dataStore!
        self.passDataToResultsScene(data: data, destination: &destinationDS)
        self.source?.navigationController?.pushViewController(scene, animated: true)
    }
    
    func routeToShowSearchFailure(message: String) {
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            alertViewController.dismiss(animated: true)
        }
        alertViewController.addAction(okAction)
        self.source?.present(alertViewController, animated: true)
    }
    
    func passDataToResultsScene(data: [MovieProtocol], destination: inout ResultsSceneDataStore) {
        destination.movies = data
    }
}
