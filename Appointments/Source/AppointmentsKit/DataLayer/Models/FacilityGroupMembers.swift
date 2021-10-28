// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityGroupMembers : Codable {
    
	let id : Int?
	let userId : Int?
	let groupId : Int?
	let memberType : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case userId = "fk_user_id"
		case groupId = "fk_group_id"
		case memberType = "v_member_type"
	}
}

extension FacilityGroupMembers {
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        memberType = try values.decodeIfPresent(String.self, forKey: .memberType)
    }
}

extension FacilityGroupMembers {
    
    init(managedObject : CDFacilityGroupMembers){
        self.id = Int(managedObject.id)
        self.userId = Int(managedObject.userId)
        self.groupId = Int(managedObject.groupId)
        self.memberType = managedObject.memberType
    }
    
}

extension FacilityGroupMembers {
    
    init(facilityGroupMembers : FacilityGroupMembers){
        self.id = facilityGroupMembers.id
        self.userId = facilityGroupMembers.userId
        self.groupId = facilityGroupMembers.groupId
        self.memberType = facilityGroupMembers.memberType
    }
    
}
