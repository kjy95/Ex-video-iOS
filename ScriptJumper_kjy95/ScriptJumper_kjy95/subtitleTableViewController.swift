//
//  subtitleTableViewController.swift
//  ScriptJumper_kjy95
//
//  Created by 김지영 on 16/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class subtitleTableViewController: UITableViewController {
    private let subArray: NSArray = ["First","Second","Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = SmiParser(subfileName: "저기..+제가+통화중이라+그런데..", ofType: "smi")
        print(parser.clockList)
        print("tableviewload")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("*\(subArray.count)")
        return subArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! subtitleTableViewCell
        
        cell.clockLabel.text = "\(subArray[indexPath.row])"
        return cell
    }
}
