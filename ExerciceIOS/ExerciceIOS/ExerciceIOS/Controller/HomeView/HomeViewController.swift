//
//  HomeViewController.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let waitingTaskFinishes = DispatchGroup()
    
    @IBOutlet weak var tableView: UITableView!
    var tableDataIdGroup : [String] = []
    var groups : [Group] = []
    var cellReuseIdentifier : String = "HomeTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupsId()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomHomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
    }
    
    
    //Call WebService to have all the ids
    func  getGroupsId(){
        let wb : WBGroup = WBGroup()
        wb.getAllId(){
            (result : [String]) in
            self.tableDataIdGroup = result
            self.getDetailByGroupsIds()
            
        }
    }
    
    func getDetailByGroupsIds(){
        waitingTaskFinishes.enter()
        for id in tableDataIdGroup{
            getGroup(id: id)
        }
    }
    
    func  getGroup(id : String){
        let wb : WBGroup = WBGroup()
        wb.getGroupById(id: id){
            (result : Group) in
            self.groups.append(result)
            //If number of Groups Ids is equal number of groups object, we can leave dispatch group
            if self.groups.count == self.tableDataIdGroup.count{
                self.waitingTaskFinishes.leave()
                self.refresh()
            }
            
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Waiting until the task finishes
        waitingTaskFinishes.wait()
        let cell : CustomHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier , for: indexPath) as! CustomHomeTableViewCell
        
      
            cell.nameLabel.text = " Name : " + groups[indexPath.row].name
            cell.descriptionLabel.text = " Description : " + groups[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataIdGroup.count
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let categoriesView : CategoriesViewController = CategoriesViewController()
        categoriesView.group = self.groups[indexPath.row]
        self.navigationController?.pushViewController(categoriesView, animated: true)
    }
    
    
    
    //Refresh tableview after result webservice
    func refresh(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


