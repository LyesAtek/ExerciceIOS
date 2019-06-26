//
//  Achivement.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

class Achievement{
    var id : Int = 0
    var name : String = ""
    var description : String = ""
    var requirement : String = ""
    
    init(id : Int, name : String,description : String, requirement : String) {
        self.id = id
        self.name = name
        self.description = description
        self.requirement = requirement
       
    }
    
    init(){
        
    }
    

}
