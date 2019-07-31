//
//  APIClient.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation

protocol APIClient {
    func send<T: APIRequest> (_ request: T, completion: @escaping ResultCallback<T.Response>)
}
