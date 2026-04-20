//
//  LibraryRowView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI

struct LibraryRowView: View {
    let album: LoggedAlbum
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(album.name)
                    .bold()
                    .foregroundStyle(.black)
                Text(album.artist)
                    .foregroundColor(.gray)
                    .foregroundStyle(.black)
                        
                if let review = album.reviews.last {
                    Text("\(review.rating) stars - \(review.text)")
                        .font(.caption)
                }
            }
            Spacer()
            AsyncImage(url: URL(string: album.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Color(red: 0.76, green: 0.84, blue: 0.88)
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)
        }
        
    }
}
