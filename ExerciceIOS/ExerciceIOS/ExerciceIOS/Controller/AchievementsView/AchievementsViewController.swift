//
//  AchievementsViewController.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 26/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import UIKit

class AchievementsViewController : UIViewController {
     let waitingTaskFinishes = DispatchGroup()
     var category : Category = Category()
     var cellReuseIdentifier : String = "CustomAchievementsCell"
     var achievements : [Achievement] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailByAchievementsIds()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomAchievementsTableCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    func getDetailByAchievementsIds(){
        for id in category.achievments{
            waitingTaskFinishes.enter()
            getAchievement(id: String(id))
        }
        waitingTaskFinishes.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            self.refresh()
        }))
    }
    
    func  getAchievement(id : String){
        let wb : WBAchievement = WBAchievement()
        wb.getAchievementById(id: id){
            (result : Achievement) in
            self.achievements.append(result)
            self.waitingTaskFinishes.leave()
        }
    }
    
    
    
    
}

extension AchievementsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return category.achievments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Waiting until the task finishes
        waitingTaskFinishes.wait()
       let cell : CustomAchievementsTableCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier , for: indexPath) as! CustomAchievementsTableCell
        cell.nameLabel.text = " Name : " + achievements[indexPath.row].name
       // cell.requirementLabel.text = "Requirement : " + achievements[indexPath.row].requirement
        return cell
        
    }
    

    
    //Refresh tableview after result webservice
    func refresh(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
