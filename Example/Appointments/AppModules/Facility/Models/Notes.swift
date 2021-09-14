// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Notes : Codable {
    
	let canManage : Bool?
	let canView : Bool?
	let canPrint : Bool?

	enum CodingKeys: String, CodingKey {

		case canManage = "canManage"
		case canView = "canView"
		case canPrint = "canPrint"
	}

}
extension Notes {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canManage = try values.decodeIfPresent(Bool.self, forKey: .canManage)
        canView = try values.decodeIfPresent(Bool.self, forKey: .canView)
        canPrint = try values.decodeIfPresent(Bool.self, forKey: .canPrint)
    }

}
