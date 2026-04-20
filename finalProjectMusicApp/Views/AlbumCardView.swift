//
//  AlbumCardView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI

struct AlbumCardView: View {
    let album: Album
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: album.imageURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: { Color.gray }
                .frame(width: 140, height: 140)
            .cornerRadius(12)
            
            Text(album.name)
                .font(.headline)
                .foregroundStyle(.black)
            Text(album.artist)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
