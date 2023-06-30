//
//  PokedexGetter.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 28-06-23.
//

import Foundation

class PokedexGetter: ObservableObject {
    
    @Published var pubPokedex = [Pokemon]()
    var n = 15
    var offset = 0
    var pokedex = [Pokemon]()
    var pokemonLeft = true
    
    //function to get a page of n pokemon, and then add those pokemon to pokedex and PubPokedex
    func fetchPokePage() {
        if self.pokemonLeft{
            let thisURL = "https://pokeapi.co/api/v2/pokemon/?offset=\(self.offset)&limit=\(self.n)"
            print(thisURL)
            self.offset += self.n
            print(thisURL)
            if let url = URL(string:thisURL){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { data, response, error in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do{
                                let pokePage = try decoder.decode(PokePage.self, from: safeData)
                                //Check if there is any pokemon left, i.e. if there is another page in next
                                if pokePage.next != nil {
                                } else {
                                    self.pokemonLeft = false
                                }
                                //Add each pokemon to the pubPokedex
                                for entry in pokePage.results {
                                    self.fetchPokemon(entry.url)
                                }
                                DispatchQueue.main.async {
                                    self.pokedex.sort {$0.id < $1.id}
                                    self.pubPokedex = self.pokedex
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    //Function to fetch a specific pokemon, then append it to the pokedex
    func fetchPokemon(_ url: String) {
        if let url = URL(string:url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do{
                            var pokemon = try decoder.decode(Pokemon.self, from: safeData)
                            pokemon.favorite = UserDefaults.standard.bool(forKey: String(pokemon.id))
                            self.pokedex.append(pokemon)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
