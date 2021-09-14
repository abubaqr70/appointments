// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Family : Codable {
    
	let canViewMessages : Bool?
	let canViewFamilyNPSSurvey : Bool?
	let canAddMessages : Bool?
	let canManageFamilyAnnouncements : Bool?

	enum CodingKeys: String, CodingKey {

		case canViewMessages = "canViewMessages"
		case canViewFamilyNPSSurvey = "canViewFamilyNPSSurvey"
		case canAddMessages = "canAddMessages"
		case canManageFamilyAnnouncements = "canManageFamilyAnnouncements"
	}

}
extension Family {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canViewMessages = try values.decodeIfPresent(Bool.self, forKey: .canViewMessages)
        canViewFamilyNPSSurvey = try values.decodeIfPresent(Bool.self, forKey: .canViewFamilyNPSSurvey)
        canAddMessages = try values.decodeIfPresent(Bool.self, forKey: .canAddMessages)
        canManageFamilyAnnouncements = try values.decodeIfPresent(Bool.self, forKey: .canManageFamilyAnnouncements)
    }
    
}
