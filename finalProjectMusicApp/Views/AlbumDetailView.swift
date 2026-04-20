//
//  AlbumDetailViw.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI
import Combine

struct AlbumDetailView: View {
    let album: Album
    @ObservedObject var store: AlbumStore
    
    @State private var showReview = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: album.imageURL)) { image in
                    image.resizable()
                } placeholder: { Color.gray }
                    .frame(width: 250, height: 250)
                
                Text(album.name)
                    .frame(alignment: .center)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                Text(album.artist)
                    .foregroundColor(.secondary)
                    .foregroundStyle(.black)
                
                Button("Log Album") {
                    store.add(album: LoggedAlbum(
                        id: album.id,
                        name: album.name,
                        artist: album.artist,
                        imageURL: album.imageURL,
                        reviews: []
                    ))
                }
                
                Button("Write Review") {
                    showReview = true
                }
                
                Divider()
                
                let logged = store.albums.first(where: { $0.id == album.id })
                
                if let reviews = logged?.reviews {
                    ForEach(reviews) { review in
                        VStack(alignment: .leading) {
                            Text("⭐️ \(review.rating)")
                            Text(review.text)
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showReview) {
            ReviewSheet(albumID: album.id, store: store)
        }
    }
}
