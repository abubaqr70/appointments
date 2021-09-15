// Copyright © 2021 Caremerge. All rights reserved.


import Foundation

protocol AuthHeaderProvider {
    var headers: [String: String] { get}
}

struct AuthHeader : AuthHeaderProvider {
    var headers: [String : String]
}


class AppointmentService: BaseService {
    
    private let baseURL: String
    private let pathVariables: [String]
    private let authHeaderProvider: AuthHeaderProvider
    private let client: APIClient
    
    init(baseURL: String,
         authHeaderProvider: AuthHeaderProvider,
         client: APIClient,pathVariables:[String]) {
        
        self.baseURL = baseURL
        self.authHeaderProvider = authHeaderProvider
        self.client = client
        self.pathVariables = pathVariables
    }
    
    public func getAppointments<ResultType: Codable>(startDate: TimeInterval,
                                                     endDate: TimeInterval,
                                                     completion: @escaping (Result<[ResultType], Error>) -> Void) {
        
        let query = ["start_date": String(startDate),
                     "end_date": String(endDate)]
        
        let endpoint: Endpoint = AppointmentEndpoint(baseURL: self.baseURL,
                                                     pathVariables: pathVariables,query: query)
        
        let request: Request = Request<Int>(endpoint: endpoint,
                                            httpMethod: .get,
                                            headers: self.authHeaderProvider.headers)
        self.dataRequest(with: self.client,
                         request: request,
                         completion: completion)
        
    }
}
