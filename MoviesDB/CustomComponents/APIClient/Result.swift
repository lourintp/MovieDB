//
//  Result.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(APIResponse?)
    case failure(String)
}

typealias ResultCallback<Value> = (Result<Value>) -> Void
