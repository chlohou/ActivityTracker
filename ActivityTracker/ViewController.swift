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
    var convertedDistance = 0.0
    var pace = 0.0
    var averagePace = 0.0
    
    var timer = Timer()
    let timerInterval = 1.0
    var timeElapsed = 0.0
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var unitConversionSwitch: UISwitch!
    
    func mileConversion(meters:Double)-> Double{
        let mile = 0.000621371192
        return meters * mile
    }
    
    func averagePaceCalculation(distance: Double) -> Double {
        if distance != 0.0 {
            pace = distance / timeElapsed
            return pace
        } else {
            return 0.0
        }
    }
    
        func paceConversion(title:String,pace:Double) -> String{
            var minPerMile = 0.0
            let factor = 26.8224 //conversion factor
            if pace != 0 {
                minPerMile = factor / pace
            }
            let minutes = Int(minPerMile)
            let seconds = Int(minPerMile * 60) % 60
            return String(format: "%@: %02.2f m/s \n\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
        }
    

    
    @IBAction func startStopButtonPress(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            // 1. Start the pedometer
            startTimer()
            self.stepCounter.startUpdates(from: Date(), withHandler: { (stepData, error) in
                if let counterData = stepData{
                    self.steps = Int(counterData.numberOfSteps)
                    if let distance = counterData.distance {
                    self.distance = Double(distance)
                    }
                    if let pace = counterData.currentPace {
                    self.pace = Double(pace)
                    }
                    
                }
            })
            // 2. Record the steps, distance, and pace
            // 3. Change Start to Stop
            sender.setTitle("Stop", for: .normal)
        } else {
            // Stop the pedometer
            stepCounter.stopUpdates()
            stopTimer()
            sender.setTitle("Start", for: .normal)
            // Segue to the next screen to display stats
        }
    }
    
/*
    I will create an activity tracker application. When a start button is pressed, it will display step count, distance, and pace.
    
    1. A slider shall be used to switch between miles and kilometers
    
    2. The user shall be able to press a button to start and stop data tracking (the workout)
    
    3. The user's stats shall be displayed upon completion of data tracking (the workout)
    
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
    
// update the labels
    func displayPedometerData(){
        //Time Elapsed
        timeElapsed += self.timerInterval
        statusLabel.text = "On: " + timeIntervalFormat(interval: timeElapsed)
        //Number of steps
            stepCountLabel.text = String(format:"Steps: %i", self.steps)
        
        // if statement for boolean slider
        
        //Distance
        distanceLabel.text = String(format:"Distance: %i", self.distance)
        //Pace
        paceLabel.text = String(format:"Pace: %i", self.pace)
        }

// creating the timer
    func startTimer(){
        if timer.isValid { timer.invalidate() }
       timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
        displayPedometerData()
    }
    
    func timerAction(timer: Timer) {
        displayPedometerData()
    }
    
    // convert seconds to hh:mm:ss as a string
    func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }
    
    // convert a pace in meters per second to a string with
    // the metric m/s and the Imperial minutes per mile
    func paceString(title:String,pace:Double) -> String{
        var minPerMile = 0.0
        let factor = 26.8224 //conversion factor
        if pace != 0 {
            minPerMile = factor / pace
        }
        let minutes = Int(minPerMile)
        let seconds = Int(minPerMile * 60) % 60
        return String(format: "%@: %02.2f m/s \n\t\t %02i:%02i min/mi",title,pace,minutes,seconds)
    }

    
    @IBAction func segueToStats(_ sender: UIButton) {
       self.performSegue(withIdentifier: "segue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! StatsViewController
        destVC.finalStepCount =  stepCountLabel.text
    }

    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
}

