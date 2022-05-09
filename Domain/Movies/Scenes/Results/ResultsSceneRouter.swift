//
//  ResultsSceneRouter.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 09.05.2022.
//

import UIKit

protocol ResultsSceneRoutingLogic {
    
}

protocol ResultsSceneDataPassing {
    var dataStore: ResultsSceneDataStore? { get }
}

final class ResultsSceneRouter: ResultsSceneRoutingLogic, ResultsSceneDataPassing {
    weak var viewController: UIViewController?
    var dataStore: ResultsSceneDataStore?
    
    private let sceneFactory: SceneFactory
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}
