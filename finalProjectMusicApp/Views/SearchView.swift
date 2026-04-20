//
//  SearchView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    @ObservedObject var store: AlbumStore
    
    init(service: SpotifyService, store: AlbumStore) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(service: service))
        self.store = store
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Albums") {
                    ForEach(viewModel.albums) { album in
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
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button("Log") {
                                let logged = LoggedAlbum(
                                    id: album.id,
                                    name: album.name,
                                    artist: album.artist,
                                    imageURL: album.imageURL,
                                    reviews: []
                                )
                                store.add(album: logged)
                            }
                        }
                    }
                }
            }
            
            
            .searchable(text: $viewModel.query)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search()
                }
            }
            .navigationTitle("Search Music")
        }
    }
    
}
