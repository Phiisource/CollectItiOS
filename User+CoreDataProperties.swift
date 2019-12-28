//
//  User+CoreDataProperties.swift
//  
//
//  Created by HENG on 17/12/2019.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dateinscription: Date?
    @NSManaged public var isAdmin: Bool
    @NSManaged public var nbpoints: Int64
    @NSManaged public var nom: String?
    @NSManaged public var prenom: String?
    @NSManaged public var userid: String?
    @NSManaged public var achat: NSSet?

}

// MARK: Generated accessors for achat
extension User {

    @objc(addAchatObject:)
    @NSManaged public func addToAchat(_ value: Lot)

    @objc(removeAchatObject:)
    @NSManaged public func removeFromAchat(_ value: Lot)

    @objc(addAchat:)
    @NSManaged public func addToAchat(_ values: NSSet)

    @objc(removeAchat:)
    @NSManaged public func removeFromAchat(_ values: NSSet)

}
