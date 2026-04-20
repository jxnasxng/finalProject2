//
//  ProfileView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @ObservedObject var store: AlbumStore
    
    var topRatedAlbums: [LoggedAlbum] {
        store.albums.filter { album in
            album.reviews.contains { $0.rating == 5 }
        }
    }
    var body: some View {
        VStack {
            Image("pfp")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()
            Text("jinasong")
                .font(.title2)
                .bold()
            Divider()
            Text("My Favorites:")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            Spacer()
            if topRatedAlbums.isEmpty {
                Text("No 5⭐️ albums yet!")
                    .foregroundStyle(.gray)
            } else {
                List(topRatedAlbums) { album in
                    HStack{
                        AsyncImage(url: URL(string: album.imageURL)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.white
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(album.name)
                                .bold()
                            Text(album.artist)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("Profile")
    }
}
