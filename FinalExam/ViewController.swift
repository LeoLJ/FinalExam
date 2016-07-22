//
//  ViewController.swift
//  FinalExam
//
//  Created by Leo on 7/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        let postsRef = ref.child("myBooks")
        postsRef.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            let bookName = String(snapshot.value!.objectForKey("bookName")!)
            let bookSummary = String(snapshot.value!.objectForKey("bookSummury")!)
            let storeAddre = String(snapshot.value!.objectForKey("storeAddress")!)
            let storeTel = String(snapshot.value!.objectForKey("storeTel")!)
            let storeWeb = String(snapshot.value!.objectForKey("storeWebsite")!)
            
            if String(snapshot.value!.objectForKey("bookImage")) != "nil" {
                let bookImageString = String(snapshot.value!.objectForKey("bookImage")!)
                let imageData = NSData(base64EncodedString: bookImageString, options: NSDataBase64DecodingOptions())
                let image = UIImage(data: imageData!)
                let bookImage = image
                let book = Books(bookName: bookName, bookSummary: bookSummary, storeAddre: storeAddre, storeWeb: storeWeb, storeTel: storeTel, bookImage: bookImage)
                BookLists.shareInstance.currentLists.insert(book, atIndex: 0)
                
            }else  {
                let bookImage = UIImage(named: "chat_sympton")
                
                let book = Books(bookName: bookName, bookSummary: bookSummary, storeAddre: storeAddre, storeWeb: storeWeb, storeTel: storeTel, bookImage: bookImage)
                BookLists.shareInstance.currentLists.insert(book, atIndex: 0)
            }
            
            

            
            self.listTableView.reloadData()
        })
        
        refreshControl.addTarget(self, action: #selector(ViewController.refresh), forControlEvents: .ValueChanged)
        self.listTableView.addSubview(refreshControl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh() {
        BookLists.shareInstance.currentLists.removeAll()
        let ref = FIRDatabase.database().reference()
        let postsRef = ref.child("myBooks")
        postsRef.observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            let bookName = String(snapshot.value!.objectForKey("bookName")!)
            let bookSummary = String(snapshot.value!.objectForKey("bookSummury")!)
            let storeAddre = String(snapshot.value!.objectForKey("storeAddress")!)
            let storeTel = String(snapshot.value!.objectForKey("storeTel")!)
            let storeWeb = String(snapshot.value!.objectForKey("storeWebsite")!)
            if String(snapshot.value!.objectForKey("bookImage")) != "nil" {
                let bookImageString = String(snapshot.value!.objectForKey("bookImage")!)
                let imageData = NSData(base64EncodedString: bookImageString, options: NSDataBase64DecodingOptions())
                let image = UIImage(data: imageData!)
                let bookImage = image
                let book = Books(bookName: bookName, bookSummary: bookSummary, storeAddre: storeAddre, storeWeb: storeWeb, storeTel: storeTel, bookImage: bookImage)
                BookLists.shareInstance.currentLists.insert(book, atIndex: 0)
                
            }else  {
                let bookImage = UIImage(named: "chat_sympton")
                
                let book = Books(bookName: bookName, bookSummary: bookSummary, storeAddre: storeAddre, storeWeb: storeWeb, storeTel: storeTel, bookImage: bookImage)
                BookLists.shareInstance.currentLists.insert(book, atIndex: 0)
            }
        })
        refreshControl.endRefreshing()
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookLists.shareInstance.currentLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BookDetailCell", forIndexPath: indexPath)
        cell.textLabel?.text = BookLists.shareInstance.currentLists[indexPath.row].bookName
        cell.imageView?.image = BookLists.shareInstance.currentLists[indexPath.row].bookImage        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoCheckingPage" {
            let vc = segue.destinationViewController as! DetailOfBookVC
            vc.index = listTableView.indexPathForSelectedRow?.row
            
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        
            BookLists.shareInstance.currentLists.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view            
        }
    }
    
}

