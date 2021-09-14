// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class FacilityProvider: FacilityDataStore {
    
    let facility: Data?
    init(facility: Data) {
        self.facility = facility
    }
    
    public var currentFacility: [String : Any]? {
        //TODO: Return User DTO
        do {
            let responseModel = try? JSONSerialization.jsonObject(with: facility ?? Data(), options: [])
            guard let dictionary = responseModel as? [String : Any] else {
                return [:]
            }
            return dictionary
        }
    }
}
