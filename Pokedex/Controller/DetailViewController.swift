//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Nam Ngây on 4/11/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//
import SwiftCSV
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var heightLbl : UILabel!
    @IBOutlet weak var weightLbl : UILabel!
    @IBOutlet weak var baseExlbl : UILabel!

        var pokeDetail : PokeModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokeDetail.name
        imageView.image = UIImage(named: "\(pokeDetail.pokeId)")
        heightLbl.text = "Height : \(pokeDetail.height)"
        weightLbl.text = "Weight : \(pokeDetail.weight)"
        baseExlbl.text = "Base Ex : \(pokeDetail.baseEx)"
    }
     
    
    @IBAction func storyBtn(_ sender: UIButton) {
    }
    
    
}
