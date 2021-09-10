// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

protocol APIClient {
    func dataRequest(_ request: URLRequestConvertible,
                     completion: @escaping (Result<Data?, Error>) -> Void)
}
