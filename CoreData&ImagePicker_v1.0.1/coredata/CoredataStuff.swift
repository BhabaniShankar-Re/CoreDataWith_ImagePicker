//
//  CoredataStuff.swift
//  CoreData&ImagePicker_v1.0.1
//
//  Created by Bhabani Shankar on 31/10/19.
//  Copyright © 2019 Bhabani Shankar. All rights reserved.
//

import UIKit
import CoreData

class CoredatStuff{
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       
    func fetchData() -> ([Profile]?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do{
            let retriveData = try managedContext.fetch(fetchRequest) as? [Profile]
            return retriveData
        }catch{
            print("error in fetching data")
        }
        return nil
    }
    
    func addData(name: String, image: UIImage?){
        guard let entity = NSEntityDescription.entity(forEntityName: "Profile", in: managedContext) else{
            fatalError("error in fetching entity")
        }
        let profile = Profile(entity: entity, insertInto: managedContext)
        var imageData:Data?{
            if let image = image{
                return image.pngData()
            }else{
                return nil
            }
            
        }
        print("coredata \(name)")
        profile.profileImage = imageData
        profile.profileName = name
    }
    
    // update removeData leter
    func removeData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        do{
            guard let result = try managedContext.fetch(fetchRequest) as? [Profile] else{
                fatalError("error in retrive data")
            }
            
            for item in result{
                managedContext.delete(item)
          }
        }catch{
            print("fetcing errror in remv data")
        }
    }
    
    func updateData(name: String, image: UIImage?, newName: String?){
        let fetchRequset = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        fetchRequset.predicate = NSPredicate(format: "profileName = %@", name)
        do{
            let result = try managedContext.fetch(fetchRequset) as! [Profile]
            print(result.count)
            if result.count == 1{
            //print(result[0].profileName!)
                if let image = image{
                result[0].profileImage = image.pngData()
                }
                if let name = newName{
                    result[0].profileName = name
                }
            }else if result.count == 0{
                addData(name: name, image: image)
            }
        }catch{
            print("fetching error for update")
            //addData(name: name, image: image)
        }
//        do{
//            try managedContext.save()
//        }catch{
//            print("errror in saving data to coredata")
//        }
    }
    
}
