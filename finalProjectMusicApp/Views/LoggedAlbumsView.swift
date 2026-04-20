//
//  LoggedAlbumsView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI

struct LoggedAlbumsView: View {
    var store: AlbumStore
    
    var body: some View {
        NavigationStack {
            List(store.albums) { album in
                HStack {
                    AsyncImage(url: URL(string: album.imageURL)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(album.name)
                        Text(album.artist)
                            .font(.subheadline)
                            .foregroundColor(Color(red: 0.76, green: 0.84, blue: 0.88))
                    }
                        
                    
                }
            }
            .background(Color(red: 0.76, green: 0.84, blue: 0.88))
            .navigationTitle("My Albums")
        }
    }
}
