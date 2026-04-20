//
//  ReviewView.swift
//  finalProjectMusicApp
//
//  Created by Jina Song on 4/16/26.
//

import SwiftUI
import Combine

struct ReviewSheet: View {
    let albumID: String
    @ObservedObject var store: AlbumStore
    @Environment(\.dismiss) var dismiss
    
    @State private var rating = 3
    @State private var text = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Stepper("Rating: \(rating) ⭐️", value: $rating, in: 1...5)
                TextField("Write review...", text: $text)
            }
            .navigationTitle("New Review")
            .toolbar {
                Button("Save") {
                    let review = Review(id: UUID(), rating: rating, text: text, date: Date())
                    store.addReview(albumID: albumID, review: review)
                    dismiss()
                }
            }
        }
    }
}
