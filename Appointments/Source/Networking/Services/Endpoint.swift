// Copyright © 2021 Caremerge. All rights reserved.


import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var pathVariables: [String]? { get }
    var queryItems: [URLQueryItem] { get }
}


extension Endpoint {
    
    var url: URL {
        guard var components = URLComponents(string: self.baseURL) else {
            preconditionFailure("Invalid Base URL")
        }
        
        if let variables = self.pathVariables {
            for variable in variables {
                components.path += "/" + variable
            }
        }
        
        components.path += "/" + self.path
        components.queryItems = self.queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components")
        }
        print(url)
        return url
    }
    
}
