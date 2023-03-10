// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityStaff : Codable {
    
    let firstName : String?
    let lastName : String?
    let staffId : Int?
    let isSelected : Bool?
    let facilityId : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case staffId = "staff_id"
        case isSelected = "isSelected"
        case facilityId = "facility_id"
    }
    
}

extension FacilityStaff {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        staffId = try values.decodeIfPresent(Int.self, forKey: .staffId)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
    }
    
}

extension FacilityStaff {
    
    init(managedObject: CDFacilityStaff) {
        
        self.staffId = Int(managedObject.staffId)
        self.firstName = managedObject.firstName
        self.lastName = managedObject.lastName
        self.isSelected = managedObject.isSelected
        self.facilityId = Int(managedObject.facilityId)
    }
    
}

extension FacilityStaff {
    
    init(facilityStaff: FacilityStaff) {
        
        self.staffId = facilityStaff.staffId
        self.firstName = facilityStaff.firstName
        self.lastName = facilityStaff.lastName
        self.isSelected = facilityStaff.isSelected
        self.facilityId = facilityStaff.facilityId
    }
    
}
