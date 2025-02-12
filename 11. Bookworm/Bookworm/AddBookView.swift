//
//  AddBookView.swift
//  Bookworm
//
//  Created by belovezhalin on 09/02/2025.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var showValidationError = false
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }

                Section {
                    Button("Save") {
                        if validateForm() {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                            modelContext.insert(newBook)
                            dismiss()
                        } else {
                            showValidationError = true
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Validation Error", isPresented: $showValidationError) {
                Button("OK", role: .cancel) { }
                } message: {
                    Text("Please fill in the title and author")
                }
        }
    }
    
    func validateForm() -> Bool {
            if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
               author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }
            return true
        }
}

#Preview {
    AddBookView()
}
