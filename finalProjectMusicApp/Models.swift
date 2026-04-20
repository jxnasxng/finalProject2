//
//  Models.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/13/26.
//

import Foundation

struct Album: Identifiable, Codable {
    let id: String
    let name: String
    let artist: String
    let imageURL: String
}

struct LoggedAlbum: Identifiable, Codable {
    let id: String
    let name: String
    let artist: String
    let imageURL: String
    var reviews: [Review]
}

struct Review: Identifiable, Codable {
    let id: UUID
    let rating: Int
    let text: String
    let date: Date
}
