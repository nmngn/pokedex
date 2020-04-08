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
    
    var player = AVAudioPlayer()
    var pokemon = [PokeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        pokeCl.delegate = self
        pokeCl.dataSource = self
        
        parseCSV()
        playMusic()
    }


    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv : CSV = try CSV(url: URL(fileURLWithPath: path!))
            let rows = csv.namedRows
        
            for row in rows {
                if let PkId = Int(row["id"]!), let PkName = row["identifier"] {
                    let poke = PokeModel(name: PkName, pokeId: PkId)
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
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokemonCollectionViewCell
       
       
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        let view = UIView(frame: cell.bounds)
        view.backgroundColor = UIColor.gray
        cell.selectedBackgroundView = view
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    
        cell.imagePkm.image = UIImage(named: "\(pokemon[indexPath.item].pokeId)")
        cell.namePkm.text = pokemon[indexPath.item].name
        
        return cell
        
    }
}
//MARK: CollectionView Delegate
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    
}
    


