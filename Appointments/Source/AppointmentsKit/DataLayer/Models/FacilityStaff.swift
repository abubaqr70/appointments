// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityStaff : Codable {
    
    let codeStatus : String?
    let email : String?
    let facilities : String?
    let facilityId : Int?
    let firstName : String?
    let lastName : String?
    let profileImageRoute : String?
    let roomNo : String?
    let staffId : Int?
    var roles : [StaffRole]?
    let isSelected : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case codeStatus = "code_status"
        case email = "email"
        case facilities = "facilities"
        case facilityId = "fk_facility_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImageRoute = "profileImageRoute"
        case roomNo = "room_no"
        case staffId = "staff_id"
        case roles = "roles"
        case isSelected = "isSelected"
    }
    
}

extension FacilityStaff {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        codeStatus = try values.decodeIfPresent(String.self, forKey: .codeStatus)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        facilities = try values.decodeIfPresent(String.self, forKey: .facilities)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        roomNo = try values.decodeIfPresent(String.self, forKey: .roomNo)
        staffId = try values.decodeIfPresent(Int.self, forKey: .staffId)
        roles = try values.decodeIfPresent([StaffRole].self, forKey: .roles)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
    }
    
}

extension FacilityStaff {
    
    init(managedObject: CDFacilityStaff) {
        
        self.staffId = Int(managedObject.staffId)
        self.facilityId = Int(managedObject.facilityId)
        self.codeStatus = managedObject.codeStatus
        self.email = managedObject.email
        self.facilities = managedObject.facilities
        self.firstName = managedObject.firstName
        self.lastName = managedObject.lastName
        self.isSelected = managedObject.isSelected
        self.profileImageRoute = managedObject.profileImageRoute
        self.roomNo = managedObject.roomNo
        self.roles = []
        for staffRole in managedObject.staff?.allObjects as? [CDStaffRole] ?? []{
            self.roles?.append(StaffRole(managedObject: staffRole))
        }
    }
    
}

extension FacilityStaff {
    
    init(facilityStaff: FacilityStaff) {
        
        self.staffId = facilityStaff.staffId
        self.facilityId = facilityStaff.facilityId
        self.codeStatus = facilityStaff.codeStatus
        self.email = facilityStaff.email
        self.facilities = facilityStaff.facilities
        self.firstName = facilityStaff.firstName
        self.lastName = facilityStaff.lastName
        self.isSelected = facilityStaff.isSelected
        self.profileImageRoute = facilityStaff.profileImageRoute
        self.roomNo = facilityStaff.roomNo
        self.roles = []
        for staffRole in facilityStaff.roles ?? []{
            self.roles?.append(StaffRole(staffRole: staffRole))
        }
    }
    
}
