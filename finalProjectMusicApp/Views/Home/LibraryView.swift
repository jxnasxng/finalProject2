//
//  LibraryView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI
import Combine

struct LibraryView: View {
    @ObservedObject var store: AlbumStore
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.albums) { album in
                    LibraryRowView(album: album)
                }
                .onDelete { indexSet in
                    indexSet.forEach { store.delete(album: store.albums[$0]) }
                }
            }
            .background(Color(red: 0.76, green: 0.84, blue: 0.88))
            .navigationTitle("My Albums")
        }
    }
}
