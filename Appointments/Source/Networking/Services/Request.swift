// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

enum RequestType: Int {
    case json
    case formData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}



struct Request<BodyType: Encodable> {
    
    let endpoint: Endpoint
    let httpMethod: HTTPMethod
    let type: RequestType
    let body: BodyType?
    let headers: [String: String]?
    
    init(endpoint: Endpoint,
         httpMethod: HTTPMethod,
         type: RequestType = .json,
         body: BodyType? = nil,
         headers: [String: String]? = nil) {
        
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.type = type
        self.body = body
        self.headers = headers
    }
}

extension Request: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        
        let url = self.endpoint.url
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.httpMethod.rawValue
        
        if let headers = self.headers {
            _ = headers.map { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        _ = self.type.headers.map { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        if let body = self.body {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .millisecondsSince1970
            urlRequest.httpBody = try encoder.encode(body)
        }
        
        return urlRequest
    }
}

extension RequestType {
    var headers: [String: String] {
        var headers = [String: String]()
        switch self {
        case .json:
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"
        case .formData:
            headers["Content-type"] = "multipart/form-data"
            headers["Accept"] = "application/json"
        }
        return headers
    }
}
