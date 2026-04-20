//
//  ContentView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var service = SpotifyService()
    @StateObject var store = AlbumStore()

    var body: some View {
//        Text("EarMatch")
//            .font(.system(size: 15))
//            .bold()
        TabView {
            HomeView(service: service, store: store)
                .tabItem { Label("Home", systemImage: "music.note.house.fill") }
            
            LibraryView(store: store)
                .tabItem { Label("My Library", systemImage: "music.pages.fill") }
            
            ProfileView(store: store)
                .tabItem { Label("Profile", systemImage: "person.circle") }
        }
        .task {
            do {
                try await service.fetchToken()
            } catch {
                print("TOKEN FETCH FAILED:", error)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
