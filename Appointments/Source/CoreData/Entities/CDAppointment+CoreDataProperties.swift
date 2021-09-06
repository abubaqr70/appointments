// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDAppointment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointment> {
        return NSFetchRequest<CDAppointment>(entityName: "CDAppointment")
    }

    @NSManaged public var title: String?

}
