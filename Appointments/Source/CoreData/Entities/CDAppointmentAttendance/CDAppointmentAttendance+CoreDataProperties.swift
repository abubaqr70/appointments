// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDAppointmentAttendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointmentAttendance> {
        return NSFetchRequest<CDAppointmentAttendance>(entityName: "CDAppointmentAttendance")
    }

    @NSManaged public var appointmentId: Int64
    @NSManaged public var cancelReminder: String?
    @NSManaged public var id: Int64
    @NSManaged public var present: String?
    @NSManaged public var reminderSent: String?
    @NSManaged public var reminderSentTime: Int64
    @NSManaged public var residentId: Int64
    @NSManaged public var users: CDAppointmentUser?
    @NSManaged public var ofAppointments: CDAppointment?

}
