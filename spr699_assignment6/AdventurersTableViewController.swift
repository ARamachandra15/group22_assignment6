//
//  AdventurersTableViewController.swift
//  spr699_assignment6
//
//  Created by Slijepcevic, Milica on 3/24/19.
//  Copyright © 2019 Samuel Randall. All rights reserved.
//

import UIKit
import CoreData


class AdventurersTableViewController: UITableViewController, AddAdventurerDelegate {
    
    var list: [NSManagedObject] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
        var response: [NSManagedObject]? = nil
        
        do {
            response = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if let response = response {
            self.list = response
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let adv = list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        //cell.textLabel?.text = adv.value(forKeyPath: "name") as? String
        //cell.imageView?.image = UIImage(named: headline.name)
        //cell.textLabel?.text = adv.value(forKeyPath: "name") as? String
        cell.nameLabel.text = adv.value(forKeyPath: "name") as? String
        cell.professionLabel.text = adv.value(forKeyPath: "profession") as? String
        cell.levelLabel.text = adv.value(forKeyPath: "level") as? String
        cell.HPLabel.text = adv.value(forKeyPath: "totalHP") as? String
        cell.attackLabel.text = adv.value(forKeyPath: "attack") as? String
        
        return cell
    }

    func addAdventurer(name: String, profession: String, level: Int, HP: Int, attack: Float) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
        
        let adv = NSManagedObject(entity: entity, insertInto: managedContext)
        
        adv.setValue(name, forKey: "name")
        adv.setValue(profession, forKey: "profession")
        adv.setValue(level, forKey: "level")
        adv.setValue(HP, forKey: "totalHP")
        adv.setValue(attack, forKey: "attack")
        
        do {
            try managedContext.save()
            
            list.append(adv)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddViewController {
            destination.delegate = self
        }
        if let destination = segue.destination as? QuestViewController{
            let indexPath = tableView.indexPathForSelectedRow
            let num = indexPath!.row
            destination.adv = list[num]
        }
    }
}
