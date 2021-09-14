// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Social : Codable {
    
	let canViewForums : Bool?
	let canViewLinks : Bool?
	let canViewVideos : Bool?
	let canViewEvents : Bool?
	let canViewGroups : Bool?
	let canViewPhotos : Bool?
	let canViewBlogs : Bool?
	let canViewAnnouncements : Bool?
	let canViewUpdates : Bool?
	let canViewUsers : Bool?

	enum CodingKeys: String, CodingKey {

		case canViewForums = "canViewForums"
		case canViewLinks = "canViewLinks"
		case canViewVideos = "canViewVideos"
		case canViewEvents = "canViewEvents"
		case canViewGroups = "canViewGroups"
		case canViewPhotos = "canViewPhotos"
		case canViewBlogs = "canViewBlogs"
		case canViewAnnouncements = "canViewAnnouncements"
		case canViewUpdates = "canViewUpdates"
		case canViewUsers = "canViewUsers"
	}

}

extension Social {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canViewForums = try values.decodeIfPresent(Bool.self, forKey: .canViewForums)
        canViewLinks = try values.decodeIfPresent(Bool.self, forKey: .canViewLinks)
        canViewVideos = try values.decodeIfPresent(Bool.self, forKey: .canViewVideos)
        canViewEvents = try values.decodeIfPresent(Bool.self, forKey: .canViewEvents)
        canViewGroups = try values.decodeIfPresent(Bool.self, forKey: .canViewGroups)
        canViewPhotos = try values.decodeIfPresent(Bool.self, forKey: .canViewPhotos)
        canViewBlogs = try values.decodeIfPresent(Bool.self, forKey: .canViewBlogs)
        canViewAnnouncements = try values.decodeIfPresent(Bool.self, forKey: .canViewAnnouncements)
        canViewUpdates = try values.decodeIfPresent(Bool.self, forKey: .canViewUpdates)
        canViewUsers = try values.decodeIfPresent(Bool.self, forKey: .canViewUsers)
    }

}
