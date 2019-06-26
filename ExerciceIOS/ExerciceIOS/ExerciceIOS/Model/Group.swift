//
//  Group.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

class Group{
    
    var id : String = ""
    var name : String = ""
    var description : String = ""
    var order : Int = 0
    
    //ID Array category model for group
    var categories : [Int] = []
    
    init(id : String) {
        self.id = id
    }
    
    init(id : String, name : String,description : String,order: Int, categories : [Int]) {
        self.id = id
        self.name = name
        self.description = description
        self.order = order
        self.categories = categories
    }
    init(){
        
    }
    
}

