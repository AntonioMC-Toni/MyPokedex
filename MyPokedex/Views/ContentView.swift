//
//  ContentView.swift
//  MyPokedex
//
//  Created by Antonio Madrid on 28-06-23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pokedexGetter = PokedexGetter()
    
    var body: some View {
        NavigationView {
            List(pokedexGetter.pubPokedex) {pokemon in
                NavigationLink(destination: PokemonView(pokemon: pokemon)) {
                    HStack{
                        VStack {
                            Text("\(pokemon.id)")
                                .font(.custom("PressStart2P-Regular", size: 16))
                            if pokemon.favorite! {
                                Image("love")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                            } else {
                                Image("poke")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                .frame(width: 50)}
                        }
                        AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")){ image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        Text("\(pokemon.name)")
                            .font(.custom("PressStart2P-Regular", size: 16))
                            .scaledToFill()
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    }
                    .onAppear{
                        //On reappear? something like that
                        pokedexGetter.pubPokedex[pokemon.id-1].favorite = UserDefaults.standard.bool(forKey: String(pokemon.id))
                        if (self.pokedexGetter.pubPokedex.last?.id == pokemon.id){
                            self.pokedexGetter.fetchPokePage()}
                    }
                    .onAppear{
                        
                    }
                }
            }
            .navigationTitle("My Pokédex")
        }
        .onAppear{
            self.pokedexGetter.fetchPokePage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
