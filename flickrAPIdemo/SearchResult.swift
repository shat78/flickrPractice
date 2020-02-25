//
//  SearchResult.swift
//  flickrAPIdemo
//
//  Created by Stan Liu on 2020/2/25.
//  Copyright © 2020 Stan Liu. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let farm: Int
    let secret: String
    let id: String
    let server: String
    let title: String
    var imageUrl: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

struct PhotoData: Decodable {
    let photo: [Photo]
}

struct SearchData: Decodable {
    let photos: PhotoData
}
