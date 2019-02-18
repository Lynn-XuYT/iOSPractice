//
//  User+CoreDataProperties.swift
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var card: Card?

}
