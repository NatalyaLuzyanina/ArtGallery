//
//  CollectionViewCell.swift
//  ArtGallery
//
//  Created by Natalia on 29.05.2024.
//

import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PaintingCollectionViewCell.self)
    
    weak var delegate: PaintingsCollectionViewControllerProtocol?
    private var currentIndexPath: IndexPath!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont(name: "Baskerville-Italic", size: 36)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont(name: "Baskerville", size: 16)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(imageTapped)
            )
        )
        return imageView
    }()
    
    private let contentContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: PaintingInfo?, indexPath: IndexPath) {
        guard let item = item else { return }
        titleLabel.text = item.title
        descriptionLabel.text = item.info
        imageView.image = item.image
        self.currentIndexPath = indexPath
    }
    
    @objc private func imageTapped() {
        guard let indexPath = currentIndexPath else { return }
        delegate?.openFullScreen(at: indexPath)
    }
    
    private func addSubviews() {
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentContainer)
        contentContainer.addArrangedSubview(titleLabel)
        contentContainer.addArrangedSubview(imageView)
        contentContainer.addArrangedSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            contentContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            contentContainer.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            contentContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
