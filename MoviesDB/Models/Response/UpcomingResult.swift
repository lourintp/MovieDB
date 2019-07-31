//
//  UpcomingResult.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

struct UpcomingResult: APIResponse {
    
    let results: [Movie]
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let dates: Dates
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case dates
    }
}
