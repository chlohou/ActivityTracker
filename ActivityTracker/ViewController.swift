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
    var finalDistance = 0.0
    
    var timer = Timer()
    let timerInterval = 1.0
    var timeElapsed = 0.0
    
    @IBOutlet weak var stepCountLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var unitConversionSwitch: UISwitch!
    @IBOutlet weak var unitLabel: UILabel!
    
    
    // - MARK: Conversions
    func mileConversion(meters:Double)-> Double{
        let mile = 0.000621371192
        return meters * mile
    }
    
        func paceConversion(pace: Double) -> Double{
            var minPerMile = 0.0
            let factor = 26.8224 //conversion factor
            if pace != 0 {
                minPerMile = factor / pace
            }
            let minutes = Int(minPerMile)
            let seconds = Int(minPerMile * 60) % 60
            return Double(minPerMile)
        }
    
    func averagePaceCalculation(distance: Double) -> Double {
        if distance != 0.0 {
            pace = distance / timeElapsed
            return averagePace
        } else {
            return 0.0
        }
    }
    
    // convert seconds to hh:mm:ss as a string
    func timeIntervalFormat(interval:TimeInterval)-> String{
        var seconds = Int(interval + 0.5) //round up seconds
        let hours = seconds / 3600
        let minutes = (seconds / 60) % 60
        seconds = seconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
    }

    // Running the pedometer
    @IBAction func startStopButtonPress(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            // 1. Start the pedometer
            startTimer()
            self.stepCounter.startUpdates(from: Date(), withHandler: { (stepData, error) in
                if let counterData = stepData{
                    self.steps = Int(counterData.numberOfSteps)
                    self.distance = (counterData.distance?.doubleValue)!
                    
                    /*
                    if let distance = counterData.distance {
                    self.distance = Double(distance)
                    }
 */
                    if let pace = counterData.currentPace {
                    self.pace = Double(pace)
                    }
                    
                }
            })
            sender.setTitle("Stop", for: .normal)
            
        } else {
            // Stop the pedometer
            stepCounter.stopUpdates()
            stopTimer()
            sender.setTitle("Start", for: .normal)
            // Segue to the next screen to display stats
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    @IBAction func switchUnitLabel(_ sender: UISwitch) {
        if sender.isOn == true {
            unitLabel.text = "Meters"
        } else {
            unitLabel.text = "Miles"
        }
    }
    
    // update the labels
    func displayPedometerData(){
        //Time Elapsed
        timeElapsed += self.timerInterval
        statusLabel.text = "On: " + timeIntervalFormat(interval: timeElapsed)
        
        //Number of steps
        stepCountLabel.text = String(format:"Steps: %i", self.steps)
        
        // if statement for boolean slider
        if unitConversionSwitch.isOn == false {
            self.distance = mileConversion(meters: distance)
            distanceLabel.text = String(format:"Distance: %i miles", distance)
            self.pace = paceConversion(pace: pace)
            paceLabel.text = String(format:"Pace: %i min/mile", pace)
        } else {
            //Distance
            distanceLabel.text = String(format:"Distance: %i meters", self.distance)
            //Pace
            paceLabel.text = String(format:"Pace: %i", self.pace)
        }
    }
    

    // - MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! StatsViewController
        destVC.finalStepCount =  stepCountLabel.text
        destVC.finalDistance = distanceLabel.text
        averagePace = averagePaceCalculation(distance: self.distance)
        destVC.averagePace = String(averagePace)
    }

    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
}

