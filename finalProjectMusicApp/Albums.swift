//
//  Albums.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import Foundation
import Combine

@MainActor
class AlbumStore: ObservableObject {
    @Published var albums: [LoggedAlbum] = []
    private let key = "albums"
    
    init() { load() }
    
    func add(album: LoggedAlbum) {
        if !albums.contains(where: { $0.id == album.id }) {
            albums.append(album)
            save()
        }
    }
    
    func addReview(albumID: String, review: Review) {
        guard let index = albums.firstIndex(where: { $0.id == albumID }) else { return }
        albums[index].reviews.append(review)
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(albums) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([LoggedAlbum].self, from: data) {
            albums = decoded
        }
    }
    func delete(album: LoggedAlbum) {
        albums.removeAll { $0.id == album.id }
        save()
    }
}
