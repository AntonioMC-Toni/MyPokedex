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
    private let pokeService: PokeServiceProtocol
    private let pokemonService: PokemonServiceProtocol
    
    init(pokeService: PokeServiceProtocol = PokeService(), pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokeService = pokeService
        self.pokemonService = pokemonService
    }
    
    //function to get a page of n pokemon, and then add those pokemon to pokedex and PubPokedex
    func fetchPokePage() {
        if self.pokemonLeft{
            pokeService.fetchPokePage(offset: offset, limit: n) { data, response in
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
            self.offset += self.n
        }
        
    }
    //Function to fetch a specific pokemon, then append it to the pokedex
    func fetchPokemon(_ url: String) {
        pokemonService.fetchPokemon(url: url) { data, response in
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
}
