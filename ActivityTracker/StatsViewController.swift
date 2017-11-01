//
//  StatsViewController.swift
//  ActivityTracker
//
//  Created by Chloe Houlihan on 10/31/17.
//  Copyright © 2017 Chloe Houlihan. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var finalStepCount : String!
    var finalDistance : String!
    var averagePace : String!
    
    
    
    @IBOutlet weak var finalAveragePaceLabel: UILabel!
    
    @IBOutlet weak var finalStepCountLabel: UILabel!
    
    @IBOutlet weak var finalDistanceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalStepCountLabel.text = finalStepCount
        finalDistanceLabel.text = finalDistance
        finalAveragePaceLabel.text = averagePace
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
