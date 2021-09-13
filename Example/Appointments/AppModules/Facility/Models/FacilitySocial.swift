// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilitySocial {
    
    var canViewAnnouncements : Bool!
    var canViewBlogs : Bool!
    var canViewEvents : Bool!
    var canViewForums : Bool!
    var canViewGroups : Bool!
    var canViewLinks : Bool!
    var canViewPhotos : Bool!
    var canViewUpdates : Bool!
    var canViewUsers : Bool!
    var canViewVideos : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        canViewAnnouncements = json["canViewAnnouncements"].boolValue
        canViewBlogs = json["canViewBlogs"].boolValue
        canViewEvents = json["canViewEvents"].boolValue
        canViewForums = json["canViewForums"].boolValue
        canViewGroups = json["canViewGroups"].boolValue
        canViewLinks = json["canViewLinks"].boolValue
        canViewPhotos = json["canViewPhotos"].boolValue
        canViewUpdates = json["canViewUpdates"].boolValue
        canViewUsers = json["canViewUsers"].boolValue
        canViewVideos = json["canViewVideos"].boolValue
    }
    
}
