//
//  APIRequest.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

protocol APIRequest: Codable {
    associatedtype Response: APIResponse
    
    var resourcePath: String { get }
}
