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

public class ResidentProvider: ResidentDataStore {
    
    public var currentResident: [String : Any]? {
        return nil
    }
    
}

public class AppointmentsPermissionProvider: PermissionProvider {
    
    public  var authorizedToManageAppointments: Bool {
        return true
    }
    public  var authorizedToViewTitleAppointments: Bool {
        return true
    }
    public  var authorizedToViewTitleAndDescriptionAppointments: Bool {
        return true
    }
}
