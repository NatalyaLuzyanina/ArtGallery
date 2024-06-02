//
//  ArtistModel.swift
//  ArtGallery
//
//  Created by Natalia on 29.05.2024.
//

import UIKit

struct ArtistsInfo: Decodable {
    let artists: [Artist]
}

struct Artist: Decodable {
    let name: String
    let bio: String
    let image: String
    let works: [PaintingInfo]
}

struct PaintingInfo: Decodable {
    let title: String
    private let imageName: String
    let info: String
    
    var image: UIImage? {
        guard
            let imageName = UIImage(named: imageName)
        else { return nil }
        return imageName
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case imageName = "image"
        case info
    }
}
