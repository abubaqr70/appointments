// Copyright © 2021 Caremerge. All rights reserved.


import Foundation


class AppointmentService: BaseService {
    
    private let baseURL: String
    private let authHeaderProvider: AuthenticationConvertible
    private let client: APIClient
    
    init(baseURL: String,
         authHeaderProvider: AuthenticationConvertible,
         client: APIClient) {
        
        self.baseURL = baseURL
        self.authHeaderProvider = authHeaderProvider
        self.client = client
    }
    
    public func getAppointments<ResultType: Codable>(for facilityID: Int,
                                                     startDate: TimeInterval,
                                                     endDate: TimeInterval,
                                                     completion: @escaping (Result<[ResultType], Error>) -> Void) {
        
        let query = ["start_date": String(startDate),
                     "end_date": String(endDate)]
        
        let pathVariables = ["facilities", String(facilityID)]
        
        let endpoint: Endpoint = AppointmentEndpoint(baseURL: self.baseURL,
                                                     pathVariables: pathVariables,
                                                     query: query)
        
        let request: Request = Request<Int>(endpoint: endpoint,
                                            httpMethod: .get,
                                            headers: self.authHeaderProvider.authenticationHeader)
        self.dataRequest(with: self.client,
                         request: request,
                         completion: completion)
        
    }
}
