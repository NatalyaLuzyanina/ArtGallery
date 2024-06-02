//
//  ArtistCell.swift
//  ArtGallery
//
//  Created by Natalia on 28.05.2024.
//

import UIKit

final class ArtistCell: UITableViewCell {
    static let identifier = String(describing: ArtistCell.self)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont(name: "Baskerville-Italic", size: 36)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = UIFont(name: "Baskerville", size: 15)
        label.textAlignment = .justified
        return label
    }()
    
    private let artistImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let contentContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let nameAndImageContainer: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ArtistCell.identifier)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with artist: Artist) {
        nameLabel.text = artist.name
        descriptionLabel.text = artist.bio
        artistImageView.image = UIImage(named: artist.image)
    }
    
    private func addSubviews() {
        nameAndImageContainer.addArrangedSubview(nameLabel)
        nameAndImageContainer.addArrangedSubview(artistImageView)
        contentContainer.addArrangedSubview(nameAndImageContainer)
        contentContainer.addArrangedSubview(descriptionLabel)
        contentView.addSubview(contentContainer)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            contentContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            artistImageView.widthAnchor.constraint(equalToConstant: 150),
            artistImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
