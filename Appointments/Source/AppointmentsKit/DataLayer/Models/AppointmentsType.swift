// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentsType : Codable {
    
    let id : Int?
    let name : String?
    let facilityId : Int?
    let rank : Int?
    let active : Bool?
    let created : Int?
    let modified : Int?
    let createdById : Int?
    let isSelected : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "v_name"
        case facilityId = "fk_facility_id"
        case rank = "i_rank"
        case active = "i_active"
        case created = "i_created"
        case modified = "i_modified"
        case createdById = "fk_created_by_id"
        case isSelected = "isSelected"
    }
    
}

extension AppointmentsType {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        createdById = try values.decodeIfPresent(Int.self, forKey: .createdById)
        isSelected = try values.decodeIfPresent(Bool.self, forKey: .isSelected)
    }
    
}

extension AppointmentsType {
    
    init(managedObject: CDAppointmentsType) {
        
        self.id = Int(managedObject.id)
        self.name = managedObject.name
        self.active = managedObject.active
        self.created = Int(managedObject.created)
        self.facilityId = Int(managedObject.facilityId)
        self.createdById = Int(managedObject.createdById)
        self.modified = Int(managedObject.modified)
        self.isSelected = managedObject.isSelected
        self.rank = Int(managedObject.rank)
    }
    
}

extension AppointmentsType {
    
    init(appointmentType: AppointmentsType) {
        
        self.id = appointmentType.id
        self.name = appointmentType.name
        self.active = appointmentType.active
        self.created = appointmentType.created
        self.facilityId = appointmentType.facilityId
        self.createdById = appointmentType.createdById
        self.modified = appointmentType.modified
        self.isSelected = appointmentType.isSelected
        self.rank = appointmentType.rank
    }
    
}
