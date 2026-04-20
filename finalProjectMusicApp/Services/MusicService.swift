//
//  MusicService.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/13/26.
//

import Foundation
import Combine

struct SpotifyTokenResponse: Codable {
    let access_token: String
}

struct SpotifySearchResponse: Codable {
    let albums: AlbumsContainer
}

struct AlbumsContainer: Codable {
    let items: [SpotifyAlbum]
}

struct SpotifyAlbum: Codable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
    let images: [SpotifyImage]
}

struct SpotifyArtist: Codable {
    let name: String
}

struct SpotifyImage: Codable {
    let url: String
}

@MainActor
class SpotifyService: ObservableObject {
    private let clientID = "2bd07d3f20664d359ca179833adec281"
    private let clientSecret = "ce600ff009884ad6b00514d9bd920d54"
    
    var token: String?
    
    func fetchToken() async throws {
        let url = URL(string: "https://accounts.spotify.com/api/token")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        
        let auth = "\(clientID):\(clientSecret)"
        let base64 = Data(auth.utf8).base64EncodedString()
        
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(SpotifyTokenResponse.self, from: data)
        token = decoded.access_token
    }
    
    func searchAlbums(query: String) async throws -> [Album] {
        try await fetchToken()
            
        guard let token = token else {
            print("TOKEN IS NIL")
            return []
        }

        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            print("Empty query")
            return []
        }

        var components = URLComponents(string: "https://api.spotify.com/v1/search")!
        components.queryItems = [
            URLQueryItem(name: "q", value: trimmed),
            URLQueryItem(name: "type", value: "album"),
            URLQueryItem(name: "limit", value: "10"),
        ]

        guard let url = components.url else {
            return []
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse {
            print("STATUS CODE:", http.statusCode)
        }

        let decoded = try JSONDecoder().decode(SpotifySearchResponse.self, from: data)

        return decoded.albums.items.map {
            Album(
                id: $0.id,
                name: $0.name,
                artist: $0.artists.first?.name ?? "",
                imageURL: $0.images.first?.url ?? ""
            )
        }
    }
    func getValidToken() async throws -> String {
        if let token = token {
            return token
        }
        
        try await fetchToken()
        
        guard let token = token else {
            throw URLError(.userAuthenticationRequired)
        }
        
        return token
    }
    
    
}
