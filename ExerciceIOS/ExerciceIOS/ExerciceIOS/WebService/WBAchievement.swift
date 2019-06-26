//
//  WBAchievements.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

public class WBAchievement : NSObject{

    func getAchievementById(id : String,_ completion: @escaping (_ result: Achievement) -> Void){
        
        var achievement : Achievement?
        let urlPath :String = GuildWars2API.baseUrl + "/v2/achievements/" + id
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
                
                achievement = self.JSONToEvent(jsonResult)
                completion(achievement ?? Achievement())
            }
            catch{
                print("error")
            }
        })
        task.resume()
    }

    func JSONToEvent(_ jsonEvents : NSObject) -> Achievement{
        
        let id = (jsonEvents as AnyObject).object(forKey: "id") as! Int
        let name = (jsonEvents as AnyObject).object(forKey: "name") as! String
        let description = (jsonEvents as AnyObject).object(forKey: "description") as! String
        let requirement = (jsonEvents as AnyObject).object(forKey: "requirement") as! String
      
        let newAchievement : Achievement = Achievement(id: id, name: name, description: description, requirement: requirement)
        return newAchievement
    }


}
