//
//  ImageGridView.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import SwiftUI

struct ImageGridView: View {
    let images: [ImageData]

    let columns = [GridItem(.adaptive(minimum: 100))]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(images) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImage(url: image.imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipped()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ImageGridView(images: [])
}
