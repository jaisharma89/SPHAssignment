//
//  YearDataVolume+CoreDataProperties.swift
//  SPHAssignment
//
//  Created by Optimum  on 12/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//
//

import Foundation
import CoreData


extension YearDataVolume {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<YearDataVolume> {
        return NSFetchRequest<YearDataVolume>(entityName: "YearDataVolume")
    }

    @NSManaged public var q1Value: Double
    @NSManaged public var q2Value: Double
    @NSManaged public var q3Value: Double
    @NSManaged public var q4Value: Double
    @NSManaged public var total: Double
    @NSManaged public var year: String?

}
