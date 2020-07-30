//
//  TableViewController.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 7/30/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var collectionData = [0:"Indoors only", 1:"Indoors and outdoor", 2:"Lap cat", 3:"Mellow", 4:"Active", 5:"Independent", 6:"Shy",7:"Playful",8:"Friendly",9:"Curious",10:"Feisty",11:"Affectionate",12:"Loves attention",13:"Aloof",14:"Swats when over stimulated",15:"Needs quiet home", 16:"Likes to be held/picked up", 17:"Doesn't like to be held/picked up", 18:"Comfortable with other cats", 19:"Not comfortable with other cats", 20:"Comfortable with dogs", 21:"Not comfortable with dogs", 22:"Good with younger kids",23:"Good with older kids", 24: "Needs a home with adults only", 25: "Needs time to know and trust you"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        cell.cellLabel.text = collectionData[indexPath.row]
        cell.tag = 25
        // Configure the cell...
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        if cell.tag == 25 {
            UITableViewCell.animate(withDuration: 0.3, animations: {
                cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            })
            cell.tag = 30
        } else {
            UITableViewCell.animate(withDuration: 0.3, animations: {
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            })
            cell.tag = 25
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
