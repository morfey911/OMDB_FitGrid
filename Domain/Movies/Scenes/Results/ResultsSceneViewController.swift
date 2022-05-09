//
//  ResultsSceneViewController.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 07.05.2022.
//

import UIKit

protocol ResultsSceneDisplayLogic: AnyObject {
    
}

final class ResultsSceneViewController: UIViewController, ResultsSceneDisplayLogic {
    
    // MARK: - Properties
    
    var interactor: ResultsSceneBusinessLogic?
    var router: (ResultsSceneRoutingLogic & ResultsSceneDataPassing)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.register(ResultsSceneViewCell.classForCoder(), forCellReuseIdentifier: "ResultsSceneViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {}
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
//        let service = DefaultNetworkService()
//        let worker = SearchSceneWorker(service: service)
        let interactor = ResultsSceneInteractor()
        let presenter = ResultsScenePresenter()
        let router = ResultsSceneRouter(sceneFactory: DefaultSceneFactory())
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
//        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension ResultsSceneViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let interactor = self.interactor,
              let movies = interactor.movies
        else {
            return 0
        }
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsSceneViewCell", for: indexPath) as! ResultsSceneViewCell
        
        cell.fill(with: interactor?.movies?[indexPath.row])
        
        return cell
    }
    
    
}
