//
//  ResultsSceneViewCell.swift
//  OMDB_FitGrid
//
//  Created by Yurii Mamurko on 09.05.2022.
//

import UIKit

final class ResultsSceneViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idAndYearContainerView: UIStackView = {
       let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [self.idLabel,
         self.yearLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [self.idAndYearContainerView,
         self.typeLabel,
         self.titleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    
    // MARK: - View lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Setup
    
    private func setup() {
        self.selectionStyle = .none
        
        self.idAndYearContainerView.addSubview(self.idLabel)
        self.idAndYearContainerView.addSubview(self.yearLabel)
        
        self.containerView.addSubview(self.idAndYearContainerView)
        self.containerView.addSubview(self.typeLabel)
        self.containerView.addSubview(self.titleLabel)
        
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.containerView)
        
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 8),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.posterImageView.widthAnchor.constraint(equalToConstant: 75),
            
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.containerView.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 20),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 8)
        ])
    }
}

extension ResultsSceneViewCell: Fillable {
    func fill(with model: MovieProtocol?) {
        guard let model = model else { return }
        
        self.idLabel.text = model.imdbID
        self.yearLabel.text = model.year
        self.typeLabel.text = model.type.rawValue
        self.titleLabel.text = model.title
        self.posterImageView.loadImageUsingCache(withUrl: model.posterURL.absoluteString)
    }
}
