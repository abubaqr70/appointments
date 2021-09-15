// Copyright © 2021 Caremerge. All rights reserved.

import Foundation


protocol BaseService {
    
    func dataRequest<ResultType: Codable>(with apiClient: APIClient,
                                          request: URLRequestConvertible,
                                          completion: @escaping (Result<ResultType, Error>) -> Void)
}


extension BaseService {
    
    func dataRequest<ResultType: Codable>(with apiClient: APIClient,
                                          request: URLRequestConvertible,
                                          completion: @escaping (Result<ResultType, Error>) -> Void) {
        apiClient.dataRequest(request) { result in
            
            switch result {
            case .failure(let error):
                completion(Result.failure(error))
            case .success(let data):
                if let data = data {
                    do {
                        let result: ResultType = try self.decode(data: data)
                        completion(Result.success(result))
                        return
                    } catch {
                        completion(Result.failure(error))
                        return
                    }
                }
            }
        }
    }
    
    func catchError(_ error: Error) {
        
    }
    
    func decode<T: Codable>(data: Data) throws -> T {
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
}
