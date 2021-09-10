// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import Alamofire

typealias URLRequestConvertible = Alamofire.URLRequestConvertible

class AlamofireClient: APIClient {
    
    func dataRequest(_ request: URLRequestConvertible,
                     completion: @escaping (Result<Data?, Error>) -> Void) {
        
        AF.request(request).validate().responseData { dataResponse in
            if let error = dataResponse.error {
                completion(Result.failure(error))
            } else {
                completion(Result.success(dataResponse.data))
            }
        }
    }
}

