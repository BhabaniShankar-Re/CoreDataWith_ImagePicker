//
//  Profile+CoreDataProperties.swift
//  CoreData&ImagePicker_v1.0.1
//
//  Created by Bhabani Shankar on 31/10/19.
//  Copyright © 2019 Bhabani Shankar. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var profileName: String?
    @NSManaged public var profileImage: Data?

}
