// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct UserGroup : Codable {
    
	let facilityCategory : FacilityCategory?
	let facilityGroupMembers : [FacilityGroupMembers]?
	let id : Int?
	let name : String?
	let facilityId : Int?
	let categoryId : Int?
	let createdAt : Int?
	let updatedAt : Int?
	let careLevelId : Int?
	let programId : Int?
	let deletedAt : Int?
	let facility_Category : FacilityCategory?
	let facility_GroupMembers : [FacilityGroupMembers]?

	enum CodingKeys: String, CodingKey {

		case facilityCategory = "facilityCategory"
		case facilityGroupMembers = "facilityGroupMembers"
		case id = "id"
		case name = "v_name"
		case facilityId = "fk_facility_id"
		case categoryId = "fk_category_id"
		case createdAt = "i_created_at"
		case updatedAt = "i_updated_at"
		case careLevelId = "fk_care_level_id"
		case programId = "fk_program_id"
		case deletedAt = "deletedAt"
		case facility_Category = "FacilityCategory"
		case facility_GroupMembers = "FacilityGroupMembers"
	}
    
}

extension UserGroup {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        facilityCategory = try values.decodeIfPresent(FacilityCategory.self, forKey: .facilityCategory)
        facilityGroupMembers = try values.decodeIfPresent([FacilityGroupMembers].self, forKey: .facilityGroupMembers)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
        careLevelId = try values.decodeIfPresent(Int.self, forKey: .careLevelId)
        programId = try values.decodeIfPresent(Int.self, forKey: .programId)
        deletedAt = try values.decodeIfPresent(Int.self, forKey: .deletedAt)
        facility_Category = try values.decodeIfPresent(FacilityCategory.self, forKey: .facility_Category)
        facility_GroupMembers = try values.decodeIfPresent([FacilityGroupMembers].self, forKey: .facility_GroupMembers)
    }
}
