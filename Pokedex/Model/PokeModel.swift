//
//  pokeModel.swift
//  Pokedex
//
//  Created by Nam Ngây on 4/7/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//

import Foundation

class PokeModel {
    private var _name : String
    private var _pokeId : Int
    private var _height : Int
    private var _weight : Int
    private var _baseEx : Int
    
    var name : String {
        return _name
    }
    
    var pokeId : Int {
        return _pokeId
    }
    var height : Int {
        return _height
    }
    var weight : Int {
        return _weight
    }
    var baseEx : Int {
        return _baseEx
    }
    
    init(name : String, pokeId: Int, pkHeight: Int, pkWeight: Int, pkBaseEx : Int) {
        self._name = name
        self._pokeId = pokeId
        self._height = pkHeight
        self._weight = pkWeight
        self._baseEx = pkBaseEx
    }
    
}
