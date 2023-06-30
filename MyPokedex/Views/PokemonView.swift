//
//  PokemonView.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 28-06-23.
//

import SwiftUI

struct PokemonView: View {
    @State var favorite: Bool
    var pokemon: Pokemon
    
    var body: some View {
        ZStack{
            VStack{
                Text("\(pokemon.id) \n\(pokemon.name)")
                    .font(.custom("PressStart2P-Regular", size: 40))
                    .lineSpacing(25)
                HStack {
                    if pokemon.sprites.front_default != nil {
                        AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 140, height: 140)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }
                    
                    if pokemon.sprites.back_default != nil {
                        AsyncImage(url: URL(string: pokemon.sprites.back_default ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 140, height: 140)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }
                    
                }
                HStack{
                    if pokemon.sprites.front_shiny != nil {
                        AsyncImage(url: URL(string: pokemon.sprites.front_shiny ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 140, height: 140)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }
                    
                    if pokemon.sprites.back_shiny != nil {
                        AsyncImage(url: URL(string: pokemon.sprites.back_shiny ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 140, height: 140)
                        .background(Color.orange)
                        .clipShape(Circle())
                    }
                }
                Text("Height: \(pokemon.heightMetres) m.\nWeight: \(pokemon.weightKilograms) kg.\nTypes:")
                    .font(.custom("PressStart2P-Regular", size: 18))
                    .lineSpacing(15)
                HStack {
                    if pokemon.types.count > 0 {VStack{
                        Image((pokemon.types.first!.type.name))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("\(pokemon.types.first!.type.name)")
                            .font(.custom("PressStart2P-Regular", size: 14))
                    }}
                    if pokemon.types.count > 1 {VStack{
                        Image((pokemon.types.last!.type.name))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("\(pokemon.types.last!.type.name)")
                            .font(.custom("PressStart2P-Regular", size: 14))
                    }}
                }
                
                
                Button(action: {
                    print("added favorite")
                    favorite.toggle()
                    UserDefaults.standard.set(favorite, forKey: String(pokemon.id))
                        }) {
                            if favorite {
                        Image("love")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            
                    } else {
                        Image("poke")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(favorite: false, pokemon: Pokemon(name: "Pikachu", id: 25, height: 4, weight: 60, sprites: PokeSprites(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png", front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png", back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png", back_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/25.png"), types: [TypeEntry(type: PokeType(name: "electric"))]))
    }
}
