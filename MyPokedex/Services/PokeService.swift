//
//  PokeService.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 30-06-23.
//

import Foundation

protocol PokeServiceProtocol {
    func fetchPokePage(offset: Int, limit: Int, completion: @escaping (Data?, URLResponse?) -> Void)
}

class PokeService: PokeServiceProtocol {
    func fetchPokePage(offset: Int, limit: Int, completion: @escaping (Data?, URLResponse?) -> Void) {
        let thisURL = "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)"
        if let url = URL(string:thisURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    completion(data, response)
                }
            }
            task.resume()
        }
    }
}

protocol PokemonServiceProtocol {
    func fetchPokemon (url: String, completion: @escaping (Data?, URLResponse?) -> Void)
}

class PokemonService: PokemonServiceProtocol {
    func fetchPokemon(url: String, completion: @escaping (Data?, URLResponse?) -> Void) {
        if let url = URL(string:url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    completion(data, response)
                }
            }
            task.resume()
        }
    }
}
