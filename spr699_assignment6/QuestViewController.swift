//
//  QuestViewController.swift
//  spr699_assignment6
//
//  Created by Jorge Rivero III on 3/29/19.
//  Copyright © 2019 Samuel Randall. All rights reserved.
//

import UIKit
import CoreData

class Enemy{
    let enemies: Array<String> = ["Dragon", "Moblin", "Witch", "Mummy"]
    let randInt: Int = Int.random(in: 0 ... 3)
    var name: String
    var hp: Int = Int.random(in: 10 ... 80)
    
    init() {
        self.name = enemies[randInt]
    }
    
    func setName(){
        
    }
}

class QuestViewController: UIViewController {
    
    var adv: NSManagedObject? = nil
    
    @IBOutlet weak var questLog: UITextView!
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var advName: UILabel!
    @IBOutlet weak var advAttack: UILabel!
    @IBOutlet weak var advHP: UILabel!
    @IBOutlet weak var advLevel: UILabel!
    @IBOutlet weak var advClass: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Currently these to not update in real time, might need to be moved to a quest function
        advHP.text = "\(adv!.value(forKeyPath: "currentHP") as! Int)/\(adv!.value(forKeyPath: "totalHP") as! Int)"
        advLevel.text =  "Level: \(adv!.value(forKeyPath: "level") as! Int)"
        advClass.text =  "Class: \(adv!.value(forKeyPath: "profession") as! String)"
        portrait.image = adv!.value(forKeyPath: "portrait") as? UIImage
        advName.text = adv!.value(forKeyPath: "name") as? String
        advAttack.text =  "Attack: \(adv!.value(forKeyPath: "attack") as! Double)"

    }
    
    func playerAttack(enemy: Enemy) -> (String){
        let attack = (adv!.value(forKeyPath: "attack") as! Double) * Double.random(in: 1...20)
        var event = ""
        enemy.hp -= Int(attack)
        if enemy.hp < 0{
            event = "The \(enemy.name) is deafeated \n A new enemy has appeared"
        }else{
            event = "\(adv!.value(forKeyPath: "name") as! String) attacks for \(Int(attack)) damage"
        }
        return (event)
    }
    
    
    func enemyAttack(enemy: Enemy) -> String{
        let actions: Array<String> = ["Attack", "Wait"]
        let randNum: Int = Int.random(in: 0...1)
        var playerHP: Int = adv!.value(forKeyPath: "currentHP") as! Int
        var event: String = ""
        
        if actions[randNum] == "Attack"{
            let attack: Int = Int.random(in: 10...50)
            playerHP -= attack
            adv!.setValue(playerHP, forKey: "currentHP")
            event = "The \(enemy.name) attacks for \(attack) damage"
        }else{
            event = "The \(enemy.name) is waiting."
        }
        return event
        
    }
    
    func quest(){
        var timer = Timer()
        var currentEnemy: Enemy? = nil
        
        //Commented code below is from the assignment page, needs to be implemented
        //timer = NSTimer.scheduledTimer(timeInterval: [time interval], target: self, selector: #selector([function to call]), userInfo: nil, repeats: true)

    }
    
    func updateView(event: String){
        questLog.text += event + "\n"
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
