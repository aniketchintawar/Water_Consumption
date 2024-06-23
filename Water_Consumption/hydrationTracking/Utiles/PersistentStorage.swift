//
//  PersistentStorage.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import Foundation
import CoreData

final class PersistentStorage{
    
    private init(){}
    static let shared = PersistentStorage()
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "hydrationTracking")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var context = persistentContainer.viewContext
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func FetchMember<T : NSManagedObject>(manageObject: T.Type) -> [T]? {
        do{
            guard let result =   try PersistentStorage.shared.context.fetch(manageObject.fetchRequest()) as? [T] else {return nil}
            return result
            
        } catch let error{
            debugPrint(error.localizedDescription)
        }
        return nil
    }
    
}
