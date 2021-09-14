// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct ClinicalReferral : Codable {
    
	let canView : Bool?
	let canManage : Bool?

	enum CodingKeys: String, CodingKey {

		case canView = "canView"
		case canManage = "canManage"
	}

}

extension ClinicalReferral {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canView = try values.decodeIfPresent(Bool.self, forKey: .canView)
        canManage = try values.decodeIfPresent(Bool.self, forKey: .canManage)
    }

}
