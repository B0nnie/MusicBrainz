//
//  ArtistNameTableViewController.swift
//  MusicBrainz
//
//  Created by Ebony Nyenya on 8/5/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class ArtistNameTableViewController: UITableViewController {
    
    var arrayOfArtists = [[String:AnyObject]]()
    
    let arrayOfArtistIDs = ["83d91898-7763-47d7-b03b-b92132375c47",
        "a3cb23fc-acd3-4ce0-8f36-1e5aa6a18432",
        "b071f9fa-14b0-4217-8e97-eb41da73f598",
        "8e68819d-71be-4e7d-b41d-f1df81b01d3f",
        "b10bbbfc-cf9e-42e0-be17-e2c3e1d2600d",
        "73e5e69d-3554-40d8-8516-00cb38737a1c",
        "5182c1d9-c7d2-4dad-afa0-ccfeada921a8",
        "534ee493-bfac-4575-a44a-0ae41e2c3fe4"]
    
    var session = NSURLSession.sharedSession()
    
    let artistURL = "http://musicbrainz.org/ws/2/artist/"
    
    let queryURL = "?inc=aliases&fmt=json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        for artistID in arrayOfArtistIDs {
            
            loadArtistInfo(artistID)
            
        }
        
        
    }
    
    func loadArtistInfo(artistID: String){
        
        if let url = NSURL(string: artistURL+artistID+queryURL){
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                
                // transform JSON into NSDictionary foundation object
                var artistDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as! NSDictionary
                
                
                self.arrayOfArtists.append(artistDictionary as! [String : AnyObject])
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                
            })
            task.resume()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfArtists.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        //pull out an artist dictionary from the arrayOfArtists and use the key 'name' to set the cell's text
        
                               //this is a dictionary
        cell.textLabel?.text = arrayOfArtists[indexPath.row]["name"] as? String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //sending data to the DetailViewController
        
                var detailVC = storyboard?.instantiateViewControllerWithIdentifier("detailVC") as! DetailViewController
        
                var artist = arrayOfArtists[indexPath.row] as [String:AnyObject]
        
                var area = artist["area"] as! [String: AnyObject]
        
                detailVC.country = area["name"] as? String
        
                var lifeSpan = artist["life-span"] as! [String : AnyObject]
        
                detailVC.yearStarted = lifeSpan["begin"] as? String
        
                detailVC.yearEnded = lifeSpan["end"] as? String
        
                detailVC.aliases = (artist["aliases"] as? [[String:AnyObject]])!
        
                navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    //another way of sending data to the DetailViewController; must setup segue identifier in storyboard
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        
//        if segue.identifier == "toDetailVC" {
//            
//            var detailVC = segue.destinationViewController as! DetailViewController
//            
//            var indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
//            
//            var artist = arrayOfArtists[indexPath!.row] as [String:AnyObject]
//            
//            var area = artist["area"] as! [String: AnyObject]
//            
//            detailVC.country = area["name"] as? String
//            
//            var lifeSpan = artist["life-span"] as! [String : AnyObject]
//            
//            detailVC.yearStarted = lifeSpan["begin"] as? String
//            
//            detailVC.yearEnded = lifeSpan["end"] as? String
//            
//            detailVC.aliases = (artist["aliases"] as? [[String:AnyObject]])!
//            
//        }
//        
//        
//    }
//    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    
    
}
