// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityCategory : Codable {
    
	let id : Int?
	let name : String?
	let facilityId : Int?
	
	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "v_name"
		case facilityId = "fk_facility_id"
	}
    
}

extension FacilityCategory {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
    }
}

extension FacilityCategory {
    
    init(managedObject : CDFacilityCategory){
        self.id = Int(managedObject.id)
        self.name = managedObject.name
        self.facilityId = Int(managedObject.facilityId)
    }
    
}

extension FacilityCategory {
    
    init(facilityCategory : FacilityCategory){
        self.id = facilityCategory.id
        self.name = facilityCategory.name
        self.facilityId = facilityCategory.facilityId
    }
    
}
