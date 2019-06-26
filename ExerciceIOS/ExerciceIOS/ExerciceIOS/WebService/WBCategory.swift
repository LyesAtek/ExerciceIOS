//
//  WBCategory.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

public class WBCategory : NSObject{

    func getCategoryById(id : String,_ completion: @escaping (_ result: Category) -> Void){
        
        var category : Category?
        let urlPath :String = GuildWars2API.baseUrl + "/v2/achievements/categories/" + id
        let url: URL = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            data, response, error -> Void in
            if error != nil {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data!,  options: .allowFragments) as! NSObject
                
                category = self.JSONToEvent(jsonResult)
                completion(category ?? Category())
            }
            catch{
                print("error")
            }
        })
        task.resume()
    }

    func JSONToEvent(_ jsonEvents : NSObject) -> Category{
        
        let id = (jsonEvents as AnyObject).object(forKey: "id") as! Int
        let name = (jsonEvents as AnyObject).object(forKey: "name") as! String
        let description = (jsonEvents as AnyObject).object(forKey: "description") as! String
        let order = (jsonEvents as AnyObject).object(forKey: "order") as! Int
        let icon = (jsonEvents as AnyObject).object(forKey: "icon") as! String
        let achievement = (jsonEvents as AnyObject).object(forKey: "achievements") as! [Int]
        let newCategory : Category = Category(id: id, name: name, description: description, order: order, icon: icon, achievement: achievement)
        return newCategory
    }
    





}
