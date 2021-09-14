// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Assessments : Codable {
    
	let canAdd : Bool?
	let canView : Bool?
	let canOverrideLock : Bool?
	let canEdit : Bool?
	let canDelete : Bool?
	let canManageV1 : Bool?
	let canUpload : Bool?
	let canManage : Bool?
	let canEditV1 : Bool?
	let canViewOrManage : Bool?
	let canAddV1 : Bool?

	enum CodingKeys: String, CodingKey {

		case canAdd = "canAdd"
		case canView = "canView"
		case canOverrideLock = "canOverrideLock"
		case canEdit = "canEdit"
		case canDelete = "canDelete"
		case canManageV1 = "canManageV1"
		case canUpload = "canUpload"
		case canManage = "canManage"
		case canEditV1 = "canEditV1"
		case canViewOrManage = "canViewOrManage"
		case canAddV1 = "canAddV1"
	}

}
extension Assessments {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canAdd = try values.decodeIfPresent(Bool.self, forKey: .canAdd)
        canView = try values.decodeIfPresent(Bool.self, forKey: .canView)
        canOverrideLock = try values.decodeIfPresent(Bool.self, forKey: .canOverrideLock)
        canEdit = try values.decodeIfPresent(Bool.self, forKey: .canEdit)
        canDelete = try values.decodeIfPresent(Bool.self, forKey: .canDelete)
        canManageV1 = try values.decodeIfPresent(Bool.self, forKey: .canManageV1)
        canUpload = try values.decodeIfPresent(Bool.self, forKey: .canUpload)
        canManage = try values.decodeIfPresent(Bool.self, forKey: .canManage)
        canEditV1 = try values.decodeIfPresent(Bool.self, forKey: .canEditV1)
        canViewOrManage = try values.decodeIfPresent(Bool.self, forKey: .canViewOrManage)
        canAddV1 = try values.decodeIfPresent(Bool.self, forKey: .canAddV1)
    }
    
}
