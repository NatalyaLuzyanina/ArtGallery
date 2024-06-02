//
//  FullScreenPaintingsViewController.swift
//  ArtGallery
//
//  Created by Natalia on 01.06.2024.
//

import UIKit

final class FullScreenPaintingsViewController: UIViewController {
    
    private var paintings: [UIImage]!
    private var indexPath: IndexPath?
    
    init(paintings: [UIImage], indexPath: IndexPath?) {
        super.init(nibName: nil, bundle: nil)
        
        self.paintings = paintings
        self.indexPath = indexPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            FullScreenPaintingViewCell.self,
            forCellWithReuseIdentifier: FullScreenPaintingViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setConstraints()
        scrollToItem()
    }
    
    private func scrollToItem() {
        DispatchQueue.main.async {
            guard let indexPath = self.indexPath else { return }
            self.collectionView.scrollToItem(
                at: indexPath,
                at: .centeredHorizontally,
                animated: false
            )
            self.collectionView.isPagingEnabled = true
        }
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FullScreenPaintingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paintings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FullScreenPaintingViewCell.identifier,
            for: indexPath
        ) as? FullScreenPaintingViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        let painting = paintings[indexPath.row]
        cell.configure(with: painting)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height
        return CGSize(width: width, height: height)
    }
}
