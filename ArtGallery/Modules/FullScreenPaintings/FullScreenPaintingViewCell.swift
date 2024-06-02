//
//  FullScreenPaintingViewCell.swift
//  ArtGallery
//
//  Created by Natalia on 01.06.2024.
//

import UIKit

final class FullScreenPaintingViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: FullScreenPaintingViewCell.self)
    
    private lazy var paintingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        paintingImageView.image = image
    }
    
    private func addSubviews() {
        contentView.addSubview(paintingImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            paintingImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            paintingImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            paintingImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            paintingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
