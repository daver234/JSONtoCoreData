//
//  Photo+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by David Rothschild on 3/12/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var author: String?
    @NSManaged public var mediaURL: String?
    @NSManaged public var tags: String?

}
