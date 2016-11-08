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
        
        albumsDocPath = documentsPath.stringByAppendingString("/Albums.plist")
        if !fileManager.fileExistsAtPath(albumsDocPath){
            try? fileManager.copyItemAtPath(plistCatPath!, toPath: albumsDocPath)
        }
        
        buttonSave.enabled=false;
        albums = readFile()
        
        artistTextField.text=albums[currentRecord].valueForKey("artist") as? String
        titleTextField.text=albums[currentRecord].valueForKey("title") as? String
        genreTextField.text=albums[currentRecord].valueForKey("genre") as? String
        
        labelRating.text=String(albums[currentRecord].valueForKey("rating") as! Int)
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
        let artistR = artistTextField.text ?? ""
        let genreR = genreTextField.text ?? ""
        let titleR = titleTextField.text ?? ""
        let yearR = Int(yearTextView.text!) ?? 0
        let ratingR = Int(labelRating.text!) ?? 0
        if currentRecord==albums.count{
            albums.addObject(["artist":artistR,"title":titleR,"genre":genreR,"date":yearR,"rating":ratingR])
        }
        
        if currentRecord >= 0 && currentRecord < albums.count {
            albums.replaceObjectAtIndex(currentRecord, withObject: ["artist":artistR,"title":titleR,"genre":genreR,"date":yearR,"rating":ratingR])
        }
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
        //TODO: return to TableView
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
}

