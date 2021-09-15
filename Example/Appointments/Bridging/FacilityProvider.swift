// Copyright © 2021 Caremerge. All rights reserved.


import Foundation
import Appointments

public class FacilityProvider: FacilityDataStore {
    
    let facility: [String:Any]?
    init(facility: [String:Any]) {
        self.facility = facility
    }
    
    public var currentFacility: [String : Any]? {
        //TODO: Return User DTO
        if facility != nil {
            return facility
        } else {
            return [:]
        }
    }
}
