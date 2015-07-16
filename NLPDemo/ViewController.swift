//
//  ViewController.swift
//  NLPDemo
//
//  Created by Rohit Gurnani on 13/07/15.
//  Copyright (c) 2015 Rohit Gurnani. All rights reserved.
//

import UIKit

class ViewController: UIViewController , WitDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var witbutton: UIButton!
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var intentText: UILabel!
    @IBOutlet weak var intentEntityText : UILabel!
    var statement = "Cook this for 15 minutes"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1 set the wit delegate
        Wit.sharedInstance().delegate = self
        
        
    }
    
    func witDidGraspIntent(outcomes: [AnyObject]!, messageId: String!, customData: AnyObject!, error e: NSError!) {
        
        if e != nil {
            println("\(e.localizedDescription)")
            return
        }
        
        var outcomes : NSArray = outcomes!
        
        var firstOutcome : NSDictionary = outcomes.objectAtIndex(0) as! NSDictionary
        println("\(firstOutcome)")
        
        var intent = firstOutcome.objectForKey("intent") as! String
        if intent == "recipe_timer"
        {
        var intentEntityValue =
        ((((firstOutcome.objectForKey("entities")! as! NSDictionary).objectForKey("duration") as! NSArray).objectAtIndex(0) as! NSDictionary).objectForKey("normalized") as! NSDictionary).objectForKey("value") as! NSNumber
        intentEntityText.text = intentEntityValue.stringValue
        intentEntityText.sizeToFit()
        println("\(intentEntityValue)")
        }
        
        intentText.text = intent
        intentText.sizeToFit()
        
        
        
    }
    
    @IBAction func speakPressed(sender : UIButton)
    {
        Wit.sharedInstance().interpretString(textField.text, customData: nil)
      //  Wit.sharedInstance().start()
    }
    
    func witDidGetAudio(chunk: NSData!) {
        println("did get audio")
    }
    
    func witDidStartRecording() {
        
    }
    
    func witDidStopRecording() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

