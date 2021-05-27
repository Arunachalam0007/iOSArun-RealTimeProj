//
//  User.swift
//  Colan_Kart
//
//  Created by ArunSha on 27/05/21.
//

import CoreData

public class User: NSManagedObject {
    @NSManaged var name:String
    @NSManaged var mobile:String
    @NSManaged var email:String
}
