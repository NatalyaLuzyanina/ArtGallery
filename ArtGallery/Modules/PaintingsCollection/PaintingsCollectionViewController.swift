//
//  PaintingsViewController.swift
//  ArtGallery
//
//  Created by Natalia on 29.05.2024.
//

import UIKit

protocol PaintingsCollectionViewControllerProtocol: AnyObject {
    func openFullScreen(at indexPath: IndexPath?)
}

final class PaintingsCollectionViewController: UIViewController {
    
    private var paintings: [PaintingInfo]!
    
    init(paintings: [PaintingInfo]) {
        super.init(nibName: nil, bundle: nil)
        
        self.paintings = paintings
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
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PaintingCollectionViewCell.self,
            forCellWithReuseIdentifier: PaintingCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PaintingsCollectionViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paintings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PaintingCollectionViewCell.identifier,
                for: indexPath
            ) as? PaintingCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let painting = paintings[indexPath.row]
        cell.configure(with: painting, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.safeAreaLayoutGuide.layoutFrame.height
        let width = view.frame.width
        return CGSize(width: width, height: height)
    }
}

extension PaintingsCollectionViewController: PaintingsCollectionViewControllerProtocol {
    func openFullScreen(at indexPath: IndexPath?) {
        var images: [UIImage] = []
        paintings.forEach {
            guard let image = $0.image else { return }
            images.append(image)
        }
        let vc = FullScreenPaintingsViewController(paintings: images, indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}
