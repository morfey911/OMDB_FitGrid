//
//  SearchViewController.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 07.05.2022.
//

import UIKit

private struct Constants {
    struct SearchTextField {
        static let height: CGFloat = 50
        static let placeholder = "Game of Thrones"
    }
    
    struct ApiKeyTextField {
        static let height: CGFloat = 50
        static let placeholder = "api key"
    }
    
    struct SearchButton {
        static let title = "Search"
        static let color = UIColor.green
    }
}

protocol SearchSceneDisplayLogic: AnyObject {
    func displaySearchResult(viewModel: SearchScene.PerformSearch.ViewModel)
    func displayError(error: String)
}

final class SearchSceneViewController: UIViewController, UITextFieldDelegate {
    
    var interactor: SearchSceneBusinessLogic?
    var router: SearchSceneRoutingLogic?
    
    // MARK: - Outlets
    
    lazy var searchTextField: UITextField = { [weak self] in
        let textField = UITextField(frame: .zero)
        
        textField.delegate = self
        textField.placeholder = Constants.SearchTextField.placeholder
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: Constants.SearchTextField.height).isActive = true
        
        return textField
    }()
    
    lazy var apiKeyTextField: UITextField = { [weak self] in
        let textField = UITextField(frame: .zero)
        
        textField.delegate = self
        textField.placeholder = Constants.ApiKeyTextField.placeholder
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: Constants.ApiKeyTextField.height).isActive = true
        
        return textField
    }()
    
    lazy var searchButton: UIButton = { [weak self] in
        let button = UIButton(type: .system)
        
        button.backgroundColor = Constants.SearchButton.color
        button.setTitle(Constants.SearchButton.title, for: .normal)
        button.addTarget(self, action: #selector(onSearchPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var containerView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        [self.apiKeyTextField,
         self.searchTextField,
         self.searchButton].forEach {
            stack.addArrangedSubview($0)
        }
        
        return stack
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        self.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /// ONLY FOR DEBUG
        self.apiKeyTextField.text = "ea5ba10b"
        self.searchTextField.text = "Game of Thrones"
        /// ONLY FOR DEBUG
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let service = DefaultNetworkService()
        let worker = SearchSceneWorker(service: service)
        let interactor = SearchSceneInteractor()
        let presenter = SearchScenePresenter()
        let router = SearchSceneRouter(sceneFactory: DefaultSceneFactory())
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.source = viewController
    }
    
    // MARK: - Actions
    
    @objc private func onSearchPressed(sender: UIButton) {
        print("Button tapped")
        let searchSceneFields = SearchScene.SearchSceneFields(apiKey: self.apiKeyTextField.text ?? "", searchInput: self.searchTextField.text ?? "")
        let request = SearchScene.PerformSearch.Request(searchSceneFields: searchSceneFields)
        self.interactor?.performSearch(request: request)
    }
    
    // MARK: - Private methods
    
    private func configure() {
        let padding: CGFloat = 20
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.containerView)
        
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: padding),
            self.containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            self.containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
}

extension SearchSceneViewController: SearchSceneDisplayLogic {
    func displaySearchResult(viewModel: SearchScene.PerformSearch.ViewModel) {
        self.router?.routeToShowMovies(data: viewModel.movies)
    }
    
    func displayError(error: String) {
        self.router?.routeToShowSearchFailure(message: error)
    }
}
