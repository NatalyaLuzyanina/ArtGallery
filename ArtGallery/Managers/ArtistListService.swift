//
//  ArtistListService.swift
//  ArtGallery
//
//  Created by Natalia on 29.05.2024.
//

import Foundation

final class ArtistListService {
    
    static let shared = ArtistListService()
    private init() {}
    
    func fetchItems(completion: @escaping ([Artist]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "artistsData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let artistsInfo = try JSONDecoder().decode(ArtistsInfo.self, from: data)
                    DispatchQueue.main.async {
                        completion(artistsInfo.artists, nil)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
