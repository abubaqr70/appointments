// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentsResultType {
    
    let id : Int?
    let title : String?
    let location : String?
    let description : String?
    let occurrenceId : Int?
    let parentEventId : Int?
    let appointmentType : Int?
    let startDate : String?
    let endDate : String?
    let startTime : String?
    let endTime : String?
    let staffName : String?
    let fullName : String?
    let roomNo : String?
    let profileImage : String?
    let residentId : Int?
    let present : String?
    
}

extension AppointmentsResultType {
    
    init(id: Int?, title: String?, location: String?, description: String?, parentEventId: Int?, appointmentType: Int?, startDate: String?, endDate: String?, startTime: String?, endTime: String?, staffName: String?, fullName: String?, roomNo: String?, profileImage: String?, residentId: Int?, present: String?, occurrenceId: Int?) {
      
        self.id = id
        self.title = title
        self.location = location
        self.description = description
        self.occurrenceId = occurrenceId
        self.parentEventId = parentEventId
        self.appointmentType = appointmentType
        self.startDate = startDate
        self.endDate = endDate
        self.startTime = startTime
        self.endTime = endTime
        self.staffName = staffName
        self.fullName = fullName
        self.roomNo = roomNo
        self.profileImage = profileImage
        self.residentId = residentId
        self.present = present
    }
    
}
