//
//  Category.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import Foundation

class Category{
    var id : Int = 0
    var name : String = ""
    var description : String = ""
    var order : Int = 0
    var icon : String = ""
    var achievments : [Int] = []
    
    init(id : Int, name : String,description : String,order: Int,icon: String, achievement : [Int]) {
        self.id = id
        self.name = name
        self.description = description
        self.order = order
        self.icon = icon
        self.achievments = achievement
    }
    init(){
        
    }
    
}

