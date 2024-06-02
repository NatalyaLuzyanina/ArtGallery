//
//  ViewController.swift
//  ArtGallery
//
//  Created by Natalia on 28.05.2024.
//

import UIKit

final class ArtistsTableViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var artists = [Artist]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArtistCell.self, forCellReuseIdentifier: ArtistCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArtists()
        view.addSubview(tableView)
        setupLayout()
        setupSearchBar()
    }
    
    private func getArtists() {
        ArtistListService.shared.fetchItems { data, error in
            guard let artists = data else {
                self.showAlert(
                    title: "Error",
                    description: error?.localizedDescription ?? "Some error"
                )
                return
            }
            self.artists = artists
            self.tableView.reloadData()
        }
    }
    
    private func showAlert(title: String?, description: String?) {
        let alert = UIAlertController(
            title: title,
            message: description,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ArtistsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ArtistCell.identifier,
                for: indexPath
            ) as? ArtistCell
        else { return UITableViewCell() }
        let artist = artists[indexPath.row]
        cell.configure(with: artist)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let artist = artists[indexPath.row]
        let vc = PaintingsCollectionViewController(paintings: artist.works)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArtistsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchQuery = searchController.searchBar.text,
            searchQuery.count > 1
        else { return }
        
        let artistIndex = findArtistIndex(byPrefix: searchQuery, in: self.artists)
        guard let artistIndex = artistIndex else {
            showAlert(title: "Artist not found", description: nil)
            return
        }
        
        let indexPath = IndexPath(row: artistIndex, section: 0)
        self.tableView.scrollToRow(
            at: indexPath,
            at: .middle,
            animated: true
        )
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func findArtistIndex(byPrefix prefix: String, in artists: [Artist]) -> Int? {
        let lowercasedPrefix = prefix.lowercased()
        
        for (index, artist) in artists.enumerated() {
            print(index)
            let lowercasedName = artist.name.lowercased()
            if lowercasedName.starts(with: lowercasedPrefix) {
                return index
            }
        }
        return nil
    }
}
