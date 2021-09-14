// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilitiesModel : Codable {
    
	let details : Details?
	let tenant : Tenant?
	let user : FacilitiesUser?
	let facilities : [Facilities]?
	let isTenant : Bool?

	enum CodingKeys: String, CodingKey {

		case details = "details"
		case tenant = "tenant"
		case user = "user"
		case facilities = "facilities"
		case isTenant = "isTenant"
	}

}

extension FacilitiesModel {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        details = try values.decodeIfPresent(Details.self, forKey: .details)
        tenant = try values.decodeIfPresent(Tenant.self, forKey: .tenant)
        user = try values.decodeIfPresent(FacilitiesUser.self, forKey: .user)
        facilities = try values.decodeIfPresent([Facilities].self, forKey: .facilities)
        isTenant = try values.decodeIfPresent(Bool.self, forKey: .isTenant)
    }

}
