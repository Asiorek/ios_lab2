//
//  ViewController.swift
//  joanna
//
//  Created by Użytkownik Gość on 13.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var yearTextView: UITextField!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    
    var song: Song?
    var deleteIndex: NSIndexPath?
    
    let plistCatPath=NSBundle.mainBundle().pathForResource("Albums", ofType: "plist")
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    let fileManager = NSFileManager.defaultManager()
    
    var albums: NSMutableArray=[]
    var albumsDocPath: String = ""
    
    var record:[String:AnyObject]=[:]
    var currentRecord: Int = 0
    
    deinit{
        writeFile()
    }
    
    func writeFile(){
        albums.writeToFile(albumsDocPath, atomically: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let song = song {
            artistTextField.text = song.artist
            titleTextField.text = song.title
            genreTextField.text = song.genre
            yearTextView.text = String(song.year)
            labelRating.text = String(song.rating)
            stepper.value = Double(song.rating)
        }
        
        print(song)
    }
    
    func readFile()->NSMutableArray{
        return NSMutableArray(contentsOfFile:albumsDocPath)!
    }

    // MARK: Actions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepper(sender: AnyObject) {
        labelRating.text = "\(stepper.value)"
    }
    
    
    func getCur(index:Int)->Int{
        if index < 0 {
            return 0
        }
        if index > albums.count-1{
            return albums.count - 1
        }
        return index as Int
    }
    
    @IBAction func clickBtnSave(sender: AnyObject) {
        
        
        print("Save button")
    }
    
    @IBAction func clickBtnDelete(sender: UIButton) {
        if albums.count == 1 {
            
            albums.removeObjectAtIndex(0)
            currentRecord=getCur(currentRecord-1)
            titleTextField.text=""
            genreTextField.text=""
            yearTextView.text=String(0)
            artistTextField.text=""
            labelRating.text=String(0)
        } else  if currentRecord < albums.count{
            albums.removeObjectAtIndex(currentRecord)
            currentRecord=getCur(currentRecord-1)
            showRecord(currentRecord)
        }
    }

    @IBAction func clickBtnCancel(sender: AnyObject) {
        let isPresentingInAddSongMode = presentingViewController is UINavigationController
        if isPresentingInAddSongMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    func showRecord(index:Int)->Void{
        artistTextField.text=albums[index].valueForKey("artist") as? String
        titleTextField.text=albums[index].valueForKey("title") as? String
        genreTextField.text=albums[index].valueForKey("genre") as? String
        
        labelRating.text=String(albums[index].valueForKey("rating") as! Int)
        yearTextView.text=String(albums[index].valueForKey("date") as! Int)
    }
    
    @IBAction func changeStepperRate(sender: UIStepper) {
        if  sender.value>5{
            sender.value=5
        }
        
        if sender.value<0{
            sender.value=0
        }
        buttonSave.enabled=true
        labelRating.text=String(Int(sender.value ))
    }
    
    @IBAction func anyProportyOfAlbumChanged(sender: AnyObject) {
        buttonSave.enabled = true
    }
    
    @IBAction func changeTxtYear(sender: UITextField) {
        buttonSave.enabled=true
    }
    
    @IBAction func changeTxtGenre(sender: UITextField) {
        buttonSave.enabled=true
    }
    
    @IBAction func changeTxtTitle(sender: UITextField) {
        buttonSave.enabled=true
    }
    
    @IBAction func changeTxtArtist(sender: AnyObject) {
        buttonSave.enabled=true
    }
    
    func exit(){
        albums.writeToFile(albumsDocPath, atomically: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if buttonSave === sender {
            let title = titleTextField.text ?? ""
            let artist = artistTextField.text ?? ""
            let genre = genreTextField.text ?? ""
            let year = Int(yearTextView.text ?? "0")
            let rating = Int(labelRating.text ?? "0")
            
            song = Song(title: title, artist: artist, genre: genre, year: year!, rating: rating!)
        }
        if buttonDelete === sender {
            let sourceViewController = segue.destinationViewController as! AlbumTableViewController
            deleteIndex = sourceViewController.tableView.indexPathForSelectedRow
        }
    }
}

