//
//  HomeView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: SearchViewModel
    @ObservedObject var store: AlbumStore
    
    init(service: SpotifyService, store: AlbumStore) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(service: service))
        self.store = store
    }
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Find albums, artists...", text: $viewModel.query)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(viewModel.albums) { album in
                            NavigationLink {
                                AlbumDetailView(album: album, store: store)
                            } label: {
                                AlbumCardView(album: album)
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxHeight: .infinity)
            }
            .navigationTitle("Discover")
            .onSubmit(of: .text) {
                Task { await viewModel.search() }
            }
        }
    }
}
