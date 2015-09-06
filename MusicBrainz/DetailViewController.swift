//
//  ViewController.swift
//  MusicBrainz
//
//  Created by Ebony Nyenya on 8/5/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var countryLbl: UILabel!
    
    
    @IBOutlet weak var yearStartedLbl: UILabel!
    
    
    @IBOutlet weak var yearEndedLbl: UILabel!
    
    @IBOutlet weak var aliasesLbl: UILabel!
    
    var country : String?
    var yearStarted: String?
    var yearEnded: String?
    var aliases: [[String:AnyObject]] = [[:]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fillLabels()
        
    }
    
    
    func fillLabels(){
        
        countryLbl.text = country
        yearStartedLbl.text = yearStarted
        yearEndedLbl.text = yearEnded
        
        
        for alias in aliases {
            
            aliasesLbl.text! += (alias["name"] as? String)! + " "
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

