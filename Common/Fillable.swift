//
//  Fillable.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 09.05.2022.
//

import Foundation

protocol Fillable {
    associatedtype T
    func fill(with model:T?) -> Void
}
