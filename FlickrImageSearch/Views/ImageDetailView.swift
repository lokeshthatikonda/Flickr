//
//  ImageDetailView.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import SwiftUI

import SwiftUI

struct ImageDetailView: View {
    let image: ImageData

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: image.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 300, height: 300)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .transition(.scale)
                            .animation(.easeInOut(duration: 0.5), value: image)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding()

                detailSection(title: "Title", content: image.title, icon: "text.quote")
                detailSection(title: "Description", content: cleanHTMLTags(from: image.description), icon: "doc.text")
                detailSection(title: "Author", content: image.author, icon: "person.fill")
                detailSection(title: "Published Date", content: formattedDate(from: image.publishedDate), icon: "calendar")

                Button(action: {
                    // Share action
                }) {
                    Label("Share Image", systemImage: "square.and.arrow.up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        }
        .navigationTitle("Image Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to remove HTML tags from a string
    private func cleanHTMLTags(from string: String) -> String {
        return string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    // Function to format the date string
    private func formattedDate(from date: Date) -> String {
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short // Optional: include the time
        return displayFormatter.string(from: date)
    }

    // Function to create a detail section
    private func detailSection(title: String, content: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .padding(4)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            Text(content)
                .font(.body)
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .padding()
        .background(Color.white.opacity(0.7))
        .cornerRadius(15)
        .shadow(radius: 10)
        .padding(.bottom, 10)
    }
}
