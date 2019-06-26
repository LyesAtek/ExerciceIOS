//
//  CategoriesViewController.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
     let waitingTaskFinishes = DispatchGroup()
    var group : Group = Group()
    var categories : [Category] = []
    var cellReuseIdentifier : String = "CategoryTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getDetailByCategoriesIds()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomCategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    func getDetailByCategoriesIds(){
      
        for id in group.categories{
            waitingTaskFinishes.enter()
            getCategory(id: String(id))
        }
        waitingTaskFinishes.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
           self.refresh()
        }))
    }
    
    func  getCategory(id : String){
        let wb : WBCategory = WBCategory()
        wb.getCategoryById(id: id){
            (result : Category) in
            self.categories.append(result)
            self.waitingTaskFinishes.leave()
        }
    }

    
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Waiting until the task finishes
        waitingTaskFinishes.wait()
        let cell : CustomCategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier , for: indexPath) as! CustomCategoriesTableViewCell
        
        cell.iconCategory?.dowloadFromServer( imageView: cell.iconCategory,link:categories[indexPath.row].icon, contentMode: .scaleAspectFill)
        cell.nameCategory.text = " Name : " + categories[indexPath.row].name
            
         //   cell.descriptionCategory.text = " Description : " + categories[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group.categories.count
    }
    
   
    
    //Refresh tableview after result webservice
    func refresh(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


