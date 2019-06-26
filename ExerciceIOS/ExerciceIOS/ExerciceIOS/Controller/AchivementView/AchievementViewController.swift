//
//  AchievementViewController.swift
//  ExerciceIOS
//
//  Created by Lyes ATEK on 27/06/2019.
//  Copyright © 2019 Lyes ATEK. All rights reserved.
//

import UIKit

class AchievementViewController : UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var requirementTextView: UITextView!
    
    @IBOutlet weak var imageAchivement: UIImageView!
    
    var achievement : Achievement = Achievement ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = achievement.name
        descriptionTextView.text = achievement.description
        requirementTextView.text = achievement.requirement
        if achievement.icon != ""{
            imageAchivement.dowloadFromServer(link: achievement.icon)
        }
    }
    


}
