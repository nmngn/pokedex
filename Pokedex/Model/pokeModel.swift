//
//  pokeModel.swift
//  Pokedex
//
//  Created by Nam Ngây on 4/7/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

class pokeModel {
    var _name : String
    var _pokeId : Int
    
    var name : String {
        return _name
    }
    
    var pokeId : Int {
        return _pokeId
    }
    
    init(name : String, pokeId: Int) {
        self._name = name
        self._pokeId = pokeId
    }
}
