// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Activities2 : Codable {
    
	let canViewActivities : Bool?
	let canEditActivities : Bool?

	enum CodingKeys: String, CodingKey {

		case canViewActivities = "canViewActivities"
		case canEditActivities = "canEditActivities"
	}
    
}
extension Activities2 {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canViewActivities = try values.decodeIfPresent(Bool.self, forKey: .canViewActivities)
        canEditActivities = try values.decodeIfPresent(Bool.self, forKey: .canEditActivities)
    }
    
}
