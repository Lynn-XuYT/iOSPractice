//
//  Card+CoreDataProperties.swift
//  LittleDemo
//
//  Created by lynn on 2019/2/18.
//  Copyright © 2019 Lynn. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var loc: String?
    @NSManaged public var user: User?

}
