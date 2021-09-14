// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class FacilityProvider: FacilityDataStore {
    
    public var currentFacility: [String : Any]? {
        //TODO: Return User DTO
        let user = Functions.getJSON("facilities") ?? Data()
        do {
            let responseModel = try? JSONSerialization.jsonObject(with: user, options: [])
            guard let dictionary = responseModel as? [String : Any] else {
                return [:]
            }
            return dictionary
        }
    }
}
