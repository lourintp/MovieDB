//
//  UpcomingMovieRequest.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

struct UpcomingMovieRequest: APIRequest {
    
    let page: Int
    
    init(page: Int) {
        self.page = page
    }
    
    var resourcePath: String {
        return "movie/upcoming?api_key=\(Constants.API_KEY)&page=\(page)"
    }
    
    typealias Response = UpcomingResult
}
