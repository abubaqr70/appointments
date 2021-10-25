// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct StaffRole : Codable {
    
    let staffId : Int?
    let isEmployee : Int?
    let isProfile : Int?
    let roleId : Int?
    let roleName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case staffId = "fk_staff_id"
        case isEmployee = "i_is_employee"
        case isProfile = "i_is_profile"
        case roleId = "role_id"
        case roleName = "role_name"
    }
    
}

extension StaffRole {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        staffId = try values.decodeIfPresent(Int.self, forKey: .staffId)
        isEmployee = try values.decodeIfPresent(Int.self, forKey: .isEmployee)
        isProfile = try values.decodeIfPresent(Int.self, forKey: .isProfile)
        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
        roleName = try values.decodeIfPresent(String.self, forKey: .roleName)
    }
    
}

extension StaffRole {
    
    init(managedObject: CDStaffRole) {
        
        self.staffId = Int(managedObject.staffId)
        self.roleName = managedObject.roleName
        self.isEmployee = Int(managedObject.isEmployee)
        self.isProfile = Int(managedObject.isProfile)
        self.roleId = Int(managedObject.roleId)
    }
    
}

extension StaffRole {
    
    init(staffRole: StaffRole) {
        
        self.staffId = staffRole.staffId
        self.roleName = staffRole.roleName
        self.isEmployee = staffRole.isEmployee
        self.isProfile = staffRole.isProfile
        self.roleId = staffRole.roleId
    }
    
}
