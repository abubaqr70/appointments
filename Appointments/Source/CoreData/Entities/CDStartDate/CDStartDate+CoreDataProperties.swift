// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDStartDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStartDate> {
        return NSFetchRequest<CDStartDate>(entityName: "CDStartDate")
    }

    @NSManaged public var date: String?
    @NSManaged public var isSynced: Bool
    @NSManaged public var timeString: String?

}
