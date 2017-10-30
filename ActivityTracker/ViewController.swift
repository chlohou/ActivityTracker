//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Chloe Houlihan on 10/30/17.
//  Copyright © 2017 Chloe Houlihan. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    let stepCounter = CMPedometer()
    var steps = 0
    var distance = 0.0
    var pace = 0.0
    
    var timer = Timer()
    let timerInterval = 1.0
    var timeElapsed = 0.0
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    

    @IBAction func startStopButtonPress(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            // 1. Start the pedometer
            // 2. Record the steps, distance, and pace
            // 3. Change Start to Stop
            sender.setTitle("Stop", for: .normal)
        } else {
            // Stop the pedometer
            // Segue to the next screen to display stats
        }
    }
    
/*
    I will create an activity tracker application. When a start button is pressed, it will display step count, distance, and pace.
    
    1. A slider shall be used to switch between miles and kilometers
    
    2. The user shall be able to press a button to start and stop data tracking (the workout)
    
    3. The user's stats shall be displayed upon completion of data tracking (the workout)
    
    4. The app shall display step count
    
    5. The app shall display distance
    
    6. The app shall display pace
    
    I will be using core motion, multiple views, and dynamic user input
  */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

