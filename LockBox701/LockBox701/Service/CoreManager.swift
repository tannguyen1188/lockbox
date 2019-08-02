//
//  CoreManager.swift
//  LockBox701
//
//  Created by mac on 7/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import CoreData

class CoreManager {
    
    //MARK: CoreData Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LockBox701")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save (path: String, isVideo: Bool){
        
        let entity = NSEntityDescription.entity(forEntityName: "Content", in: context)!
        let content = Content(entity: entity, insertInto: context)
        
    
        content.setValue(path, forKey: "path")
        content.setValue(isVideo, forKey: "isVideo")
        
        saveContext()
        
        print("Saved to Core: \(path)")
    }
    
    

    func load() -> [Content] {
        
        let fetchRequest = NSFetchRequest<Content>(entityName: "Content")

        var content = [Content] ()
        do {
            content = try context.fetch(fetchRequest)
            
        } catch {
            print("Couldn't fetch images: \(error.localizedDescription)")
        }
        
        print("Image Count: \(content.count)")
        
        return content
    }
    

    func remove(content: Content) {

        let fetchRequest = NSFetchRequest<Content>(entityName: "Content")
        let predicate = NSPredicate(format: "path==%@", content.path!)

        fetchRequest.predicate = predicate
        var cont = [Content]()

        do {
            cont = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch images: \(error.localizedDescription)")
        }
        var i = 1
        for con in cont {
            
            if (i == 1) {
            print("Deleted image ")
                context.delete(con)
                i += 1
            } else {
                
                break
            }
        }
        

        saveContext()
    }

    
    
    
    
    //MARK: Helpers
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
}
