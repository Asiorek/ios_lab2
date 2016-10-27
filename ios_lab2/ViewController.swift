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
    //    @IBOutlet weak var artistTextField: NSLayoutConstraint!
    //    @IBOutlet weak var titleTextField: UITextField!
    //    @IBOutlet weak var genreTextField: UITextField!
    //    @IBOutlet weak var yearTextView: UITextField!
    //
    //    @IBOutlet weak var numberRate: UILabel!
    //
    //    @IBOutlet weak var buttonRates: UIStepper!
    //    @IBOutlet weak var buttonPrev: UIButton!
    //    @IBOutlet weak var buttonNext: UIButton!
    //    @IBOutlet weak var buttonSave: UIButton!
    //    @IBOutlet weak var buttonDelete: UIButton!
    //    @IBOutlet weak var buttonNew: UIButton!
    //
    //    @IBOutlet weak var numberRecord: UITextView!
    
    //    var albums: NSMutableArray?
    
    
    var albums = ""
    var albumIndex = AlbumSingleton.sharedInstance.Albums
    
    @IBOutlet weak var textFieldTitle: UITextField!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var buttonSave: UIButton!
    
    let
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albums = AlbumSingleton.sharedInstance.Albums
        
        
        textFieldTitle.text = albums[albumIndex].title
        buttonSave.enabled = false
        
        //
        //        albums = NSMutableArray(contentsOfFile:"Albums");
        // Do any additional setup after loading the view, typically from a nib.
        //        let album = albums[0]
        
        //        artistTextField.text = album["artist"] as? String
    }
    
    // MARK: Actions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepper(sender: AnyObject) {
        labelRating.text = "\(stepper.value)"
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        AlbumSingleton.sharedInstance.Albums[albumIndex].title = textFieldTitle.text!
    }
    
    @IBAction func anyProportyOfAlbumChanged(sender: AnyObject) {
        buttonSave.enabled = true
    }
}

