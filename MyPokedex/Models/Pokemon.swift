//
//  Pokemon.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 28-06-23.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let name: String
    let id: Int
    let height: Int //height in decimeters
    var heightMetres: String {
        return String(format: "%.1f", (Float(height)/10))
    }
    let weight: Int //weight in hectograms
    var weightKilograms: String {
        return String(format: "%.1f", (Float(weight)/10))
    }
    let sprites: PokeSprites
    let types: [TypeEntry]
}

struct PokeSprites: Codable {
    let front_default: String?
    let front_shiny: String?
    let back_default: String?
    let back_shiny: String?
}

struct TypeEntry: Codable {
    let type: PokeType
}

struct PokeType: Codable {
    let name: String
}
