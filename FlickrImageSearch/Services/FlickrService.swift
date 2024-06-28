//
//  FlickrService.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import Foundation
import Combine

struct FlickrService {
    static func fetchImages(for query: String) -> AnyPublisher<[ImageData], Error> {
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(query)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ -> [ImageData] in
                let flickrResponse = try JSONDecoder().decode(FlickrResponse.self, from: data)
                return flickrResponse.items.map {
                    ImageData(
                        title: $0.title,
                        description: $0.description,
                        author: $0.author,
                        publishedDate: ISO8601DateFormatter().date(from: $0.published) ?? Date(),
                        imageURL: URL(string: $0.media.m)!)
                }
            }
            .eraseToAnyPublisher()
    }
}

struct FlickrResponse: Codable {
    let items: [FlickrImage]
}

struct FlickrImage: Codable {
    let title: String
    let description: String
    let author: String
    let published: String
    let media: FlickrMedia
}

struct FlickrMedia: Codable {
    let m: String
}
