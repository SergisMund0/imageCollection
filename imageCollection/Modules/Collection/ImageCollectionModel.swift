//
//  ImageCollectionModel.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 18/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

struct TumblrTaggedPhotos: Decodable {
    let response: [Response]
}

struct Response: Decodable {
    let blogName: String
    let slug: String
    let tags: [String]
    let photos: [SizedPhotos]?
    
    enum CodingKeys: String, CodingKey {
        case blogName = "blog_name"
        case slug
        case tags
        case photos
    }
}

struct SizedPhotos: Decodable {
    let caption: String
    let originalSize: OriginalSize
    
    enum CodingKeys: String, CodingKey {
        case caption
        case originalSize = "original_size"
    }
}

struct OriginalSize: Decodable {
    let url: String
    let width: Int
    let height: Int
}
