// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDStartDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStartDate> {
        return NSFetchRequest<CDStartDate>(entityName: "CDStartDate")
    }

    @NSManaged public var date: Date?
    @NSManaged public var timeString: String?
    @NSManaged public var ofAppointments: CDAppointment?

}
