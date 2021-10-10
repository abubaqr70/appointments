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
        
        let query = ["i_started_date": String(startDate),
                     "i_ended_date": String(endDate)]
        
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
    
    public func syncAppointments<ResultType: Codable>(for facilityID: Int,
                                                      params: [Appointment],
                                                     completion: @escaping (Result<ResultType, Error>) -> Void) {
        
        let pathVariables = ["facilities", String(facilityID)]
        let endpoint: Endpoint = AppointmentMarksEndpoint(baseURL: self.baseURL,
                                                     pathVariables: pathVariables, query: [:])
        
        do{
            let data = try JSONEncoder().encode(params)
            do {
                let responseModel = try? JSONSerialization.jsonObject(with: data, options: [])
                guard let dictionary = responseModel as? [[String : Any]] else {
                    return
                }
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted])
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                print(decoded)
            }
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
        let request: Request = Request<[Appointment]>(endpoint: endpoint,
                                            httpMethod: .post,
                                            type: .json,
                                            body: params,
                                            headers: self.authHeaderProvider.authenticationHeader)
        self.dataRequest(with: self.client,
                         request: request,
                         completion: completion)
        
    }
    
}
