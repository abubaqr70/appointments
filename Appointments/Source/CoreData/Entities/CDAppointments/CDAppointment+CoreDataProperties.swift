// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDAppointment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointment> {
        return NSFetchRequest<CDAppointment>(entityName: "CDAppointment")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var endingDate: Double
    @NSManaged public var eventLength: Int64
    @NSManaged public var facilityId: Int64
    @NSManaged public var groupId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var isSynced: Bool
    @NSManaged public var isTherapy: Bool
    @NSManaged public var location: String?
    @NSManaged public var occurrenceId: Int64
    @NSManaged public var parentEventId: Int64
    @NSManaged public var residentId: Int64
    @NSManaged public var startingDate: Double
    @NSManaged public var therapistId: Int64
    @NSManaged public var therapyId: Int64
    @NSManaged public var title: String?
    @NSManaged public var appointmentAttendance: NSSet?
    @NSManaged public var appointmentTag: NSSet?
    @NSManaged public var endDate: CDEndDate?
    @NSManaged public var startDate: CDStartDate?
    @NSManaged public var user: CDAppointmentUser?
    @NSManaged public var userGroup: CDUserGroup?

}

// MARK: Generated accessors for appointmentAttendance
extension CDAppointment {

    @objc(addAppointmentAttendanceObject:)
    @NSManaged public func addToAppointmentAttendance(_ value: CDAppointmentAttendance)

    @objc(removeAppointmentAttendanceObject:)
    @NSManaged public func removeFromAppointmentAttendance(_ value: CDAppointmentAttendance)

    @objc(addAppointmentAttendance:)
    @NSManaged public func addToAppointmentAttendance(_ values: NSSet)

    @objc(removeAppointmentAttendance:)
    @NSManaged public func removeFromAppointmentAttendance(_ values: NSSet)

}

// MARK: Generated accessors for appointmentTag
extension CDAppointment {

    @objc(addAppointmentTagObject:)
    @NSManaged public func addToAppointmentTag(_ value: CDAppointmentTags)

    @objc(removeAppointmentTagObject:)
    @NSManaged public func removeFromAppointmentTag(_ value: CDAppointmentTags)

    @objc(addAppointmentTag:)
    @NSManaged public func addToAppointmentTag(_ values: NSSet)

    @objc(removeAppointmentTag:)
    @NSManaged public func removeFromAppointmentTag(_ values: NSSet)

}
