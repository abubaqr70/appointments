// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentEndpoint: Endpoint {

    let baseURL: String
    let queryItems: [URLQueryItem]
    let pathVariables: [String]?
    let path: String
    
    init(baseURL: String,
         pathVariables: [String]? = nil,
         query: [String: String],
         path: String) {
        self.path = path
        self.baseURL = baseURL
        self.pathVariables = pathVariables
        self.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
