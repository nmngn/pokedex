//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Nam Ngây on 4/8/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//
import Foundation
import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var imagePkm : UIImageView!
    @IBOutlet weak var namePkm : UILabel!
    
    
    func loadPokemon(pokeModel : PokeModel) {
        
        imagePkm.image = UIImage(named: "\(pokeModel.pokeId)")
        namePkm.text = pokeModel.name.capitalized
      
    }
    
}
