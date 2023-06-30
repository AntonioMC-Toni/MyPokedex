//
//  PokePage.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 28-06-23.
//

import Foundation

struct PokePage: Codable {
    let next: String?
    let results: [PokeEntry]
}

struct PokeEntry: Codable {
    let name: String
    let url: String 
}
