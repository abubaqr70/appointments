// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDEndDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEndDate> {
        return NSFetchRequest<CDEndDate>(entityName: "CDEndDate")
    }

    @NSManaged public var date: String?
    @NSManaged public var isSynced: Bool
    @NSManaged public var timeString: String?

}
