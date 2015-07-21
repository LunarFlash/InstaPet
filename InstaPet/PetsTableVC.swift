//
//  PetsTableVC.swift
//  InstaPet
//
//  Created by Terry Wang on 7/20/15.
//  Copyright (c) 2015 Vento LLC. All rights reserved.
//

import UIKit

class PetsTableVC: PFQueryTableViewController {

    /*
    Within the first init, a couple of things happen:
    
    With the super.init() call, initialization is propagated to the superclass PFQueryTableViewController, which in turn initializes itself.
    Then, pullToRefreshEnabled is set to true. It’s an inherited property of PFQueryTableViewController. The special variable self refers to the current scope, thus the instance of the class.
    Then, we enable pagination and set the maximum number of objects in our table to 25.
    Finally, we store parameter className in the instance property parseClassName.
    */
    // Init programmatically
    override init(style: UITableViewStyle, className: String?) {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
        
        self.parseClassName = "Pet"
    }
    

    // A required initializer init for Storyboard
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 25
        
        self.parseClassName = "Pet"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    Override the superclass method with the same name (and signature), with the statement override.
    Declare the method with func and it’s name, queryForTable.
    Declare the parameters of the method between ( and ). In our case there’s no parameters.
    Finally write -> PFQuery, the return type of the method.
    */
    override func queryForTable() -> PFQuery {
        var query:PFQuery = PFQuery(className: self.parseClassName!)
        
        if (objects?.count == 0) {
            // in case the query is empty, we set the cachePolicy property on the query. It’s value is constant PFCachePolicy.CacheThenNetwork, which means the query will first look in the offline cache for objects and if it doesn’t find any, it will download the objects from the online Parse datastore. When the table view is first put on screen, in our app, this if-statement is most likely to get executed once.
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending("name")
        return query
    }
    
    // returning a explicitly unwrapped PFTableViewCell instance rather than UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let cellIdentifier:String = "Cell"
        var cell:PFTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
        
        if (cell == nil) {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        // Normally, when you work with an optional, you need to unwrap it. Before you can do it, you must check whether the optional is nil. You can’t unwrap an optional that has the possibility of being nil. In our case, we use optional binding (if-let) to verify if the optional is non-nil. If it contains a value, we make that value available as a temporary constant (pfObject).
        if let pfObject = object {
            // casts pfObject[""name"] to optional String?, because the object may or may not have a property called name and it could be nil.
            cell?.textLabel?.text = pfObject["name"] as? String
        }
        // Why is it optional? When there’s no cell to dequeue, this method will return nil.
        return cell;
        
    }
    

}
