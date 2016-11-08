//
//  AlbumTableViewController.swift
//  ios_lab2
//
//  Created by macdt on 08/11/2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    
    var album = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Load data
        loadAlbum()
    }
    
    func loadAlbum(){
        
        let plistPath = NSBundle.mainBundle().pathForResource("Albums", ofType: "plist")
        let list:NSArray = NSArray(contentsOfFile: plistPath!)!
        
        for song:NSDictionary in (list as NSArray as! [NSDictionary]) {
            let newSong = Song(
                title: song.valueForKey("title") as! String,
                artist: song.valueForKey("artist") as! String,
                genre: song.valueForKey("genre") as! String,
                year: song.valueForKey("date") as! Int,
                rating: song.valueForKey("rating") as! Int
            )
            
            album.append(newSong!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return album.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SongTableViewCell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongTableViewCell
        
                let song = album[indexPath.row]
                cell.labelTitle.text = song.title
                cell.labelArtist.text = song.artist
        
                return cell
    }
 

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails" {
            
            let songDetailViewController = segue.destinationViewController as! ViewController
            if let selectedSongCell = sender as? SongTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedSongCell)!
                let selectedSong = album[indexPath.row]
                songDetailViewController.song = selectedSong
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new song")
        }
    }
    
    
    @IBAction func unwindToSongList(sender: UIStoryboardSegue) {
        if let sourceController = sender.sourceViewController as? ViewController, song = sourceController.song, deleteIndex:NSIndexPath? = sourceController.deleteIndex {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if (deleteIndex != nil) {
                    album.removeAtIndex((deleteIndex?.row)!)
                    tableView.deleteRowsAtIndexPaths([deleteIndex!], withRowAnimation: .Fade)
                    
                }
                else {
                    album[selectedIndexPath.row] = song
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
                
            }
            else {
                
                let newIndexPath = NSIndexPath(forRow: album.count, inSection: 0)
                album.append(song)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveSongs();
        }
    }
    
    
    func saveSongs() {
        print("Save songs")
        let plistPath = NSBundle.mainBundle().pathForResource("songs", ofType: "plist")!
        print(plistPath)
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let albumsDocPath = documentsPath.stringByAppendingString("/songs.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDocPath) {
            print("copy")
            try! fileManager.copyItemAtPath(plistPath, toPath: albumsDocPath)
        }
        
        let albums = album.convertToNSMutableArray(album)
        print(albumsDocPath)
        
        albums.writeToFile(plistPath, atomically: true)
    }


}
