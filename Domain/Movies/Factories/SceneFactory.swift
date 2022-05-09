//
//  SceneFactory.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 08.05.2022.
//

import UIKit

protocol SceneFactory {
    func makeSearchScene() -> UIViewController
    func makeSearchResultScene() -> UIViewController
}

final class DefaultSceneFactory: SceneFactory {
    func makeSearchScene() -> UIViewController {
        return SearchSceneViewController()
    }
    
    func makeSearchResultScene() -> UIViewController {
        return ResultsSceneViewController()
    }
}
