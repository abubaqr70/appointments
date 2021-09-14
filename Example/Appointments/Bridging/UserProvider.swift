// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class UserProvider: UserDataStore {
    
    public  var currentUser: [String : Any]? {
        //TODO: Return User DTO
        let user = Functions.getJSON("user_detail") ?? Data()
        do {
            let responseModel = try? JSONSerialization.jsonObject(with: user, options: [])
            guard let dictionary = responseModel as? [String : Any] else {
                return [:]
            }
            return dictionary
        }
    }
}
