// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct UserGroup : Codable {
    
	let facilityCategory : FacilityCategory?
    var facilityGroupMembers : [FacilityGroupMembers]?
	let id : Int?
	let name : String?
	let facilityId : Int?
	let categoryId : Int?

	enum CodingKeys: String, CodingKey {

		case facilityCategory = "facilityCategory"
		case facilityGroupMembers = "facilityGroupMembers"
		case id = "id"
		case name = "v_name"
		case facilityId = "fk_facility_id"
		case categoryId = "fk_category_id"
	}
    
}

extension UserGroup {
    
    init(){
        self.id = nil
        self.name = nil
        self.facilityId = nil
        self.categoryId = nil
        self.facilityCategory = nil
        self.facilityGroupMembers = nil
    }
    
    init(managedObject: CDUserGroup){
        self.id = Int(managedObject.id)
        self.name = managedObject.name
        self.facilityId = Int(managedObject.facilityId)
        self.categoryId = Int(managedObject.categoryId)
        self.facilityCategory = FacilityCategory(managedObject: managedObject.facilityCategory ?? CDFacilityCategory())
        self.facilityGroupMembers = []
        for members in managedObject.facilityGroupMembers?.allObjects as? [CDFacilityGroupMembers] ?? [] {
            self.facilityGroupMembers?.append(FacilityGroupMembers(managedObject: members))
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        facilityCategory = try values.decodeIfPresent(FacilityCategory.self, forKey: .facilityCategory)
        facilityGroupMembers = try values.decodeIfPresent([FacilityGroupMembers].self, forKey: .facilityGroupMembers)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
    }
}
