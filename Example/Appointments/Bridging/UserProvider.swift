// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class UserProvider: UserDataStore {
    
    public  var currentUser: [String : Any]? {
        //TODO: Return User DTO
        let user = Functions.getJSON("user_detail") ?? Data()
        do {
            let responseModel = try JSONSerialization.jsonObject(with: user, options: [])
            guard let dictionary = responseModel as? [String : Any] else {
                return [:]
            }
            return dictionary
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return [:]
    }
}
