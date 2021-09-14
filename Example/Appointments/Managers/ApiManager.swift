// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit
import Alamofire

enum VoidResult {
    case success(result:AFDataResponse<Any>)
    case failure(NSError)
}

struct errorCode{
    
    /**
     501 mean session expired. Need to login again
     */
    static var loginAgain = 501
    /**
     200 mean sucess response
     */
    static var success = 200
    /**
     401 mean invalid credentials
     */
    static var permissionDenied = 401
    
}

class ApiManager: NSObject {
    
    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "app" : "staff" ,
            "platform" : "ios",
            "version" : "2.6.11"
        ]
        if let authToken = UserDefaults.standard.string(forKey: "api_key") {
            headers["x-care-merge-api-token"] = authToken.trimmingCharacters(in: .whitespacesAndNewlines) //+ "42"
        }
        return headers
    }
    
    class func getRequest(with url: String,parameters: [String:Any]?, completion: @escaping (_ result: VoidResult) -> ())
    {
        print(url)
        print(ApiManager.headers())
        if ReachabilityNet.isConnectedToNetwork(){
            AF.request(url,method: .get, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers:ApiManager.headers()).responseJSON { (response:AFDataResponse<Any>) in
                if response.response?.statusCode == errorCode.success{
                    if response.value != nil
                    {
                        completion(.success(result: response))
                        
                    } else if let error = response.error {
                        completion(.failure(error as NSError))
                    } else {
                        fatalError("No error, no failure")
                    }
                }else if response.response?.statusCode == errorCode.permissionDenied {
                    Functions.hideActivity()
                    Functions.showAlert(message: "Invalid credentials. Please try again.")
                }else {
                    Functions.hideActivity()
                    Functions.showAlert(message: "Server is not responding.")
                }
            }
        }else{
            Functions.showAlert(message: "No Internet Connection.")
        }
    }
    
    class func postRequest(with url: String,parameters: [String:Any], completion: @escaping (_ result: VoidResult) -> ())
    {
        print(url)
        print(parameters)
        print(ApiManager.headers())
        if ReachabilityNet.isConnectedToNetwork(){
            AF.request(url,method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ApiManager.headers()).responseJSON { (response:AFDataResponse<Any>) in
                if response.response?.statusCode == errorCode.success{
                    if response.value != nil
                    {
                        completion(.success(result: response))
                    } else if let error = response.error {
                        completion(.failure(error as NSError))
                    } else {
                        fatalError("No error, no failure")
                    }
                }else if response.response?.statusCode == errorCode.permissionDenied {
                    Functions.hideActivity()
                    Functions.showAlert(message: "Invalid credentials. Please try again.")
                }else{
                    Functions.hideActivity()
                    Functions.showAlert(message: "Server is not responding.")
                }
            }
        }else{
            Functions.showAlert(message: "No Internet Connection.")
        }
        
    }
    
    class func queryString(_ value: String, params: [String: Any]) -> String? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map {URLQueryItem(name: $0, value: $1 as? String) }
        
        return components?.url?.absoluteString
    }
    
}

