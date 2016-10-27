//
//  AlbumsTableViewController.swift
//  joanna
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      var albums = [Album]()
        
        let album = Album()
        album.title = "x"
        
        albums.append(album)
        
        let album2 = Album()
        album2.title = "y"
        albums.append(album2)

    
        AlbumSingleton.sharedInstance.Albums = albums
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return albums.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath)

        cell.textLabel?.text = albums[indexPath.row]
        cell.detailTextLabel?.text = "a"

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let vc = segue.destinationViewController as? ViewController{
            if let cell = sender as? UITableViewCell {
                let index = tableView.indexPathForCell(cell)
                    vc.album = albums[(index?.row)!]
            }
        }
    }
}
