//
//  QuestViewController.swift
//  spr699_assignment6
//
//  Created by Jorge Rivero III on 3/29/19.
//  Copyright © 2019 Samuel Randall. All rights reserved.
//

import UIKit
import CoreData

class QuestViewController: UIViewController {
    
    var adv: NSManagedObject? = nil
    
    var timer = Timer() 
    @IBOutlet weak var questLog: UITextView!
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var advName: UILabel!
    @IBOutlet weak var advAttack: UILabel!
    @IBOutlet weak var advHP: UILabel!
    @IBOutlet weak var advLevel: UILabel!
    @IBOutlet weak var advClass: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advHP.text = "\(adv!.value(forKeyPath: "currentHP") as! Int)/\(adv!.value(forKeyPath: "totalHP") as! Int)"
        advLevel.text =  "Level: \(adv!.value(forKeyPath: "level") as! Int)"
        advClass.text =  "Class: \(adv!.value(forKeyPath: "profession") as! String)"
        portrait.image = adv!.value(forKeyPath: "portrait") as? UIImage
        advName.text = adv!.value(forKeyPath: "name") as? String
        advAttack.text =  "Attack: \(adv!.value(forKeyPath: "attack") as! Double)"

    }
    func quest(){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
