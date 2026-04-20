//
//  SearchViewModel.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var albums: [Album] = []
    @Published var featuredAlbums: [Album] = []
    let service: SpotifyService

    init(service: SpotifyService) {
        self.service = service
    }

    func search() async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            albums = []
            return
        }

        do {
            let results = try await service.searchAlbums(query: trimmed)
            self.albums = results
        } catch {
            print("ERROR:", error)
        }
    }
}
