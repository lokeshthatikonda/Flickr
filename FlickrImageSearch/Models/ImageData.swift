//
//  ImageData.swift
//  FlickrImageSearch
//
//  Created by Lokesh Thatikonda on 06/28/24.
//

import Foundation

struct ImageData: Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    let author: String
    let publishedDate: Date
    let imageURL: URL
}
