//
//  DataBaseHandler.swift
//  Colan_Kart
//
//  Created by ArunSha on 27/05/21.
//

import CoreData
import UIKit

class DataBaseHandler {
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else { return nil}
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: viewContext) else { return nil }
        let object = T(entity: entityDescription, insertInto: viewContext)
        return object
    }
    
    func fetch<T: NSManagedObject> (_type: T.Type, mobileInput:String) -> [T] {
        let fetchRequest = T.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "mobile CONTAINS %@", mobileInput)
        do {
            let result = try viewContext.fetch(fetchRequest) as! [T]
            return result
        } catch  {
            print("DEBUG: ",error.localizedDescription)
            return []
        }
    }
    
    func fetchAll<T: NSManagedObject> (_type: T.Type) -> [T] {
        let fetchRequest = T.fetchRequest()
        do{
            let result = try viewContext.fetch(fetchRequest) as! [T]
            return result
        } catch  {
            print("DEBUG: ",error.localizedDescription)
            return []
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch  {
            print("DEBUG: ",error.localizedDescription)
        }
    }
    
}
