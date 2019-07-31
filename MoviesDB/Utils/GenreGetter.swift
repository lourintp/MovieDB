//
//  GenreGetter.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/29/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

public class GenreGetter {
    
    private var genreList: [Int] = []
    
    init(_ genreList: [Int]) {
        self.genreList = genreList
    }
    
    func getAll() -> String {
        var genreString: String = ""
        for each in genreList {
            genreString = "\(genreString)\(Genre(rawValue: each)?.description ?? ""), "
        }
        
        if (genreString.isEmpty) {
            return ""
        }
        genreString.removeLast(2)
        return genreString
    }
}
