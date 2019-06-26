//
//  WBGroup.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

public class WBGroup : NSObject{
    
    func getAllId(_ completion: @escaping (_ result: [String]) -> Void){
        
        var groupsId : [String] = []
        let urlPath :String = GuildWars2API.baseUrl + "/v2/achievements/groups"
        let url: URL = URL(string: urlPath)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            data, response, error -> Void in
            if error != nil {
                // If there is an error in the web request, print it to the console
                print(error!.localizedDescription)
            }
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data!,  options: .allowFragments) as! NSArray
                
                groupsId = self.JSONToEventArray(jsonResult)
                completion(groupsId)
            }
            catch{
                print("error")
            }
        })
        task.resume()
    }
    
    func getGroupById(id : String,_ completion: @escaping (_ result: Group) -> Void){
        
        var group : Group?
        let urlPath :String = GuildWars2API.baseUrl + "/v2/achievements/groups/" + id
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
                
                group = self.JSONToEvent(jsonResult)
                completion(group ?? Group())
            }
            catch{
                print("error")
            }
        })
        task.resume()
    }
    
    func JSONToEvent(_ jsonEvents : NSObject) -> Group{
        
        let id = (jsonEvents as AnyObject).object(forKey: "id") as! String
        let name = (jsonEvents as AnyObject).object(forKey: "name") as! String
        let description = (jsonEvents as AnyObject).object(forKey: "description") as! String
        let order = (jsonEvents as AnyObject).object(forKey: "order") as! Int
        let categories = (jsonEvents as AnyObject).object(forKey: "categories") as! [Int]
        let newGroup : Group = Group(id: id, name: name, description: description, order: order, categories: categories)
        return newGroup;
    }
    
    func JSONToEventArray(_ jsonEvents : NSArray) -> [String]{
        var groupsId : [String] = []
        for object in jsonEvents{
            groupsId.append( (object as AnyObject) as! String)
        }
        return groupsId
    }
    
    
}
