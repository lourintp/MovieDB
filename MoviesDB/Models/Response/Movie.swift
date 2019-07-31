//
//  Movie.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

struct Movie: APIResponse {
    
    let id: Int
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
    let title: String
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let backdropPath: String?
    let adult: Bool
    let overview: String?
    let releaseDate: String?
    let genreIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
    
    func formattedReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        let date = dateFormatter.date(from: releaseDate ?? "")
        
        return dateFormatter.string(from: date ?? Date())
    }
}
