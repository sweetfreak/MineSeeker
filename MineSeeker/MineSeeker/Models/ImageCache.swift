//
//  ImageCache.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/4/25.
//

import SwiftUI

class ImageCache {
    
    static let shared = ImageCache()
    
    private var cache: [String: Image] = [:]
    
    func image(named name: String) -> Image {
        if let cached = cache[name] {
            return cached
        } else {
            let newImage = Image(name)
            cache[name] = newImage
            return newImage
        }
    }
    
    func clear() {
        cache.removeAll()
    }
    
}

