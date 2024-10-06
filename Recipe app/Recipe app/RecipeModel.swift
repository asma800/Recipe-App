//
//  RecipeModel.swift
//  Recipe app
//
//  Created by Asma on 10/5/24.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
    
    var id: String {
        uuid
    }
}
