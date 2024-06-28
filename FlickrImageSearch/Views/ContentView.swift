//
//  ContentView.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    @State private var showSearchBar: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                searchBar
                    .zIndex(1) // Ensure the search bar stays on top of other views

                ScrollView {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 50) // Space to avoid overlapping with the search bar
                    } else {
                        ImageGridView(images: viewModel.images)
                            .padding(.top, 50) // Space to avoid overlapping with the search bar
                    }
                }
            }
            .navigationTitle("Flickr Image Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("Search images...", text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 10)
                .onTapGesture {
                    showSearchBar.toggle()
                }

            if showSearchBar {
                Button(action: {
                    viewModel.searchText = ""
                    showSearchBar.toggle()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                .transition(.scale)
            }
        }
        .background(Color.white) // Ensure background color for the search bar area
        .shadow(radius: 5) // Optional: Add shadow to the search bar
        .padding(.bottom, 5)
        .animation(.easeInOut(duration: 0.2), value: showSearchBar)
    }
}

// Helper to dismiss keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


#Preview {
    ContentView()
}
