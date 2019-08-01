//
//  MovieDBAPIClient.swift
//  MoviesDB
//
//  Created by Thiago Lourin on 7/28/19.
//  Copyright © 2019 Lourin. All rights reserved.
//

import Foundation
import Alamofire

public class MovieDBAPIClient: APIClient {
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response>) -> Void) where T : APIRequest {
        
        var endpoint: URLRequest?
        
        do {
            endpoint = try self.endpoint(for: request)
        } catch {
            completion(.failure(error.localizedDescription))
        }
        
        Alamofire.request(endpoint!).validate().responseData { (response) in
            
            guard let data = response.data else { return }
            let stringData = String(data: data, encoding: String.Encoding.utf8) ?? ""
            
            if let status = response.response?.statusCode {
                
                if (status <= 400 && status >= 200) {
                    if (stringData.isEmpty) {
                        completion(.success(nil))
                        return
                    }
                    
                    do {
                        let decoded = try JSONDecoder().decode(T.Response.self, from: data)
                        completion(.success(decoded))
                        return
                    } catch let error {
                        completion(.failure(error.localizedDescription))
                        return
                    }
                } else {
                    completion(.failure(stringData))
                    return
                }
            } else if let err = response.error {
                completion(.failure(err.localizedDescription))
                return
            }
        }
        
    }
    
    private func endpoint<T: APIRequest>(for request: T) throws -> URLRequest {
        guard let baseUrl = URL(string: request.resourcePath, relativeTo: URL(string: Constants.BASE_URL)) else {
            fatalError("Bad resourceName: \(request.resourcePath)")
        }
        
        print(baseUrl.absoluteString)
        var requestData = URLRequest(url: baseUrl)
        
        requestData.httpMethod = HTTPMethod.get.rawValue
        requestData.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")        
        print(requestData)
        
        return requestData
    }
    
    private func toData<T: APIRequest>(_ data: T) throws -> Data {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        jsonEncoder.dateEncodingStrategy = .iso8601
        
        return try jsonEncoder.encode(data)
    }
}
