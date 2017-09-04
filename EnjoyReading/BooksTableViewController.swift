//
//  BooksTableViewController.swift
//  EnjoyReading
//
//  Created by MEI KU on 2017/9/4.
//  Copyright © 2017年 Natalie KU. All rights reserved.
//

import UIKit
import SafariServices

class BooksTableViewController: UITableViewController {
    
    var books:[Book] = []
    
    func getBooks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            books = try context.fetch(Book.fetchRequest())
        }
        catch {
            print("error")
        }
    }
    
    @objc func getAddBookNoti(noti:Notification) {
        getBooks()
        tableView.reloadData()
    }
    
    @IBAction func safari(_ sender: UIBarButtonItem) {
        
        if let url = URL(string:"https://www.google.com.tw/maps/") {
            let safariViewController = SFSafariViewController(url:url)
            present(safariViewController, animated: true, completion: nil)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getBooks()
        let notiName = Notification.Name("addBookNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(BooksTableViewController.getAddBookNoti(noti:)), name: notiName, object: nil)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        books.remove(at: indexPath.row)
        context.delete(book)
        appDelegate.saveContext()
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    
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
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

