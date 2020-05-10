//
//  StoryViewController.swift
//  Pokedex
//
//  Created by Nam Ngây on 5/10/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var storyLbl : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storyLbl.backgroundColor = UIColor.white.withAlphaComponent(0.6)
       
    }
    

  

}
