//
//  CoreData.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import UIKit
import CoreData

class CoreData {
    static var shared: CoreData {
        return CoreData()
    }
    fileprivate init(){}
    
    // MARK: Get ASTRONOMY POD
    func getAstronomyListMethod(_ completion:@escaping(_ astronomyListArr:[AstronomyDetailsModel]) -> Void) {
        var arrAstronomyDetail = [AstronomyDetailsModel]()
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataTables.astronomyList)
        do {
            arrAstronomyDetail.removeAll()
            let arrAstronomyInfo = try managedContext.fetch(fetchRequest)
            if arrAstronomyInfo.count > 0 {
                for i in 0..<arrAstronomyInfo.count {
                    let detailInfo = arrAstronomyInfo[i]
                    var objAstronomyModel = AstronomyDetailsModel()
                    objAstronomyModel.copyright = detailInfo.value(forKeyPath: AstronomyTablesKeys.copyright) as? String ?? ""
                    objAstronomyModel.date = detailInfo.value(forKeyPath: AstronomyTablesKeys.date) as? String ?? ""
                    objAstronomyModel.explanation = detailInfo.value(forKeyPath: AstronomyTablesKeys.explanation) as? String ?? ""
                    objAstronomyModel.hdurl = detailInfo.value(forKeyPath: AstronomyTablesKeys.hdUrl) as? String ?? ""
                    objAstronomyModel.mediaType = detailInfo.value(forKeyPath: AstronomyTablesKeys.mediaType) as? String ?? ""
                    objAstronomyModel.serviceVersion = detailInfo.value(forKeyPath: AstronomyTablesKeys.serviceVersion) as? String ?? ""
                    objAstronomyModel.title = detailInfo.value(forKeyPath: AstronomyTablesKeys.title) as? String ?? ""
                    objAstronomyModel.url = detailInfo.value(forKeyPath: AstronomyTablesKeys.url) as? String ?? ""
                    objAstronomyModel.favourite = detailInfo.value(forKeyPath: AstronomyTablesKeys.favourite) as? Bool ?? false
                    arrAstronomyDetail.append(objAstronomyModel)
                }
                completion(arrAstronomyDetail)
            } else {
                completion(arrAstronomyDetail)
            }
        } catch let error as NSError {
            completion(arrAstronomyDetail)
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Save ASTRONOMY Detail In DB
    func saveAstronomyDetailInDB(_ objAstronomyModel: AstronomyDetailsModel,completion:@escaping() -> Void) {
        let managedContext = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: CoreDataTables.astronomyList, in: managedContext)!
        let objSaveAstronomy = NSManagedObject(entity: entity, insertInto: managedContext)
        // MARK: Save Values
        objSaveAstronomy.setValue(objAstronomyModel.copyright, forKeyPath: AstronomyTablesKeys.copyright)
        objSaveAstronomy.setValue(objAstronomyModel.date, forKeyPath: AstronomyTablesKeys.date)
        objSaveAstronomy.setValue(objAstronomyModel.explanation, forKeyPath: AstronomyTablesKeys.explanation)
        objSaveAstronomy.setValue(objAstronomyModel.hdurl, forKeyPath: AstronomyTablesKeys.hdUrl)
        objSaveAstronomy.setValue(objAstronomyModel.mediaType, forKeyPath: AstronomyTablesKeys.mediaType)
        objSaveAstronomy.setValue(objAstronomyModel.serviceVersion, forKeyPath: AstronomyTablesKeys.serviceVersion)
        objSaveAstronomy.setValue(objAstronomyModel.title, forKeyPath: AstronomyTablesKeys.title)
        objSaveAstronomy.setValue(objAstronomyModel.url, forKeyPath: AstronomyTablesKeys.url)
        objSaveAstronomy.setValue(false, forKeyPath: AstronomyTablesKeys.favourite)
        do {
            try managedContext.save()
            completion()
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
    }
    
    // MARK: Update ASTRONOMY Detail In DB
    func updateAstrononyDetailInDB(_ date: String,favourite: Bool,completion:@escaping() -> Void) {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataTables.astronomyList)
        fetchRequest.predicate = NSPredicate(format: "\(AstronomyTablesKeys.date) = %@", date)
        do {
            let arrAstronomyList = try managedContext.fetch(fetchRequest)
            let objectAstronomy = arrAstronomyList[0]
            objectAstronomy.setValue(favourite, forKeyPath: AstronomyTablesKeys.favourite)
            do {
                try managedContext.save()
                completion()
            }
            catch {
                debugPrint(error.localizedDescription)
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataName.astronomyData)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint("Unresolved error:- \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Save Context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error:- \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
