//
//  ListSceneInteractor.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 09.05.2022.
//

import Foundation

protocol ResultsSceneDataStore {
    var movies: [MovieProtocol]? { get set }
}

protocol ResultsSceneBusinessLogic {
    var movies: [MovieProtocol]? { get }
}

final class ResultsSceneInteractor: ResultsSceneDataStore, ResultsSceneBusinessLogic {
    var presenter: ResultsScenePresentationLogic?
    
    var movies: [MovieProtocol]?
}
