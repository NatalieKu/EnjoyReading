//
//  DesignTableViewController.swift
//  EnjoyReading
//
//  Created by MEI KU on 2017/9/4.
//  Copyright © 2017年 Natalie KU. All rights reserved.
//

import UIKit
import CoreData

class DesignTableViewController: UITableViewController {
    var books:[Book] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBooks()
        tableView.reloadData()
    }
    
    func getBooks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request:NSFetchRequest<Book> = Book.fetchRequest()
        request.predicate = NSPredicate(format: "genres == %d" , 3 )
        let sortDescriptor = NSSortDescriptor(key: "genres", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            books = try context.fetch(request)
        }
        catch {
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        // Configure the cell...
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.authur
        return cell
    }
}

