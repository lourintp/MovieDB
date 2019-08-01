//
//  Genre.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

enum Genre: Int {
    
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case History = 36
    case Horror = 27
    case Music = 10402
    case Mistery = 9648
    case Romance = 10749
    case ScienceFiction = 878
    case TVMovie = 10770
    case Thriller = 53
    case War = 10752
    case Western = 37
    
    
    var description: String {
        switch self {
        case .Action:
            return "Action"
        case .Adventure:
            return "Adventure"
        case .Animation:
            return "Animation"
        case .Comedy:
            return "Comedy"
        case .Crime:
            return "Crime"
        case .Documentary:
            return "Documentary"
        case .Drama:
            return "Drama"
        case .Family:
            return "Family"
        case .Fantasy:
            return "Fantasy"
        case .History:
            return "History"
        case .Horror:
            return "Horror"
        case .Music:
            return "Music"
        case .Mistery:
            return "Mistery"
        case .Romance:
            return "Romance"
        case .ScienceFiction:
            return "Science Fiction"
        case .TVMovie:
            return "TV Movie"
        case .Thriller:
            return "Thriller"
        case .War:
            return "War"
        case .Western:
            return "Western"        
        }
    }
}
