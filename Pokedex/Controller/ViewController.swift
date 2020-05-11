//
//  ViewController.swift
//  Pokedex
//
//  Created by Nam Ngây on 4/7/20.
//  Copyright © 2020 Nam Ngây. All rights reserved.
//
import SwiftCSV
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var pokeCl: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var player = AVAudioPlayer()
    var pokemon = [PokeModel]()
    var filteredPokemon = [PokeModel]()
    var isFilteringMode = false
    
    var detailVC : DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        pokeCl.delegate = self
        pokeCl.dataSource = self
        searchBar.delegate = self
        
        parseCSV()
        playMusic()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv : CSV = try CSV(url: URL(fileURLWithPath: path!))
            let rows = csv.namedRows
            
            for row in rows {
                if let pkId = Int(row["id"]!),
                    let pkName = row["identifier"],
                    let pkHeight = Int(row["height"]!),
                    let pkWeight = Int(row["weight"]!),
                    let pkBaseEx = Int(row["base_experience"]!) {
                    let poke = PokeModel(name: pkName, pokeId: pkId, pkHeight: pkHeight, pkWeight: pkWeight, pkBaseEx: pkBaseEx)
                    pokemon.append(poke)
                }
            }
            
        } catch {
            print("Parsing CSV file has error \(error)")
        }
        
    }
    
    func playMusic() {
        let music = Bundle.main.url(forResource: "pokemon", withExtension: "mp3")
        
        do {
            player = try AVAudioPlayer(contentsOf: music!)
            
        } catch {
            print("Music fail \(error)")
        }
    }
    @IBAction func musicBtn(_ sender: UIButton) {
        
        player.prepareToPlay()
        player.numberOfLoops = -1
        if player.isPlaying {
            player.pause()
            sender.alpha = 0.2
        } else {
            player.play()
            sender.alpha = 1.0
        }
    }

}

//MARK: CollectionView Data Source
extension ViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFilteringMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokemonCollectionViewCell
        
        var poke : PokeModel!
        if isFilteringMode {
            poke = filteredPokemon[indexPath.item]
            cell.imagePkm.image = UIImage(named: "\(poke.pokeId)")
            cell.namePkm.text = poke.name
            
        } else {
            poke = pokemon[indexPath.item]
            cell.imagePkm.image = UIImage(named: "\(pokemon[indexPath.item].pokeId)")
            cell.namePkm.text = pokemon[indexPath.item].name
        }
        
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        let view = UIView(frame: cell.bounds)
        view.backgroundColor = UIColor.gray
        cell.selectedBackgroundView = view
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        
        
        return cell
        
    }
}
//MARK: CollectionView Delegate
extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    
        var pokeMon : PokeModel!
        if isFilteringMode {
            pokeMon = filteredPokemon[indexPath.item]
        
        } else {
            pokeMon = pokemon[indexPath.item]
            
        }
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "DetailPokemonVC") as! DetailViewController
        viewController.pokeDetail = pokeMon
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

//MARK: SearchBar Delegate
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            isFilteringMode = false
            pokeCl.reloadData()
        } else {
            isFilteringMode = true
            let searchText = searchText.lowercased()
            let filtered = pokemon.filter({ $0.name.lowercased().contains(searchText) }) 
            filteredPokemon = filtered.isEmpty ? pokemon : filtered
        }
        pokeCl.reloadData()
    }
    
}

