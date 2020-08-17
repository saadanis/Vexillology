//
//  Flag.swift
//  Vexillology
//
//  Created by Saad Anis on 2020.08.16.
//

import Foundation

struct Flag: Codable, Hashable {
    // var id = UUID()
    let country: String
    let name: String
    let img: String
    let adopted: String
    let continent: String
    //  var favorite: Bool = false
}

class Flags: ObservableObject {
    
    @Published var favorites: [Flag] = []
    
    init() {
        load()
    }
    
    func load() {
        
        // Get the favorite flags.
        let favoritesString = UserDefaults.standard.stringArray(forKey: "favorites") ?? ["Qatar"]
        let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
        let favoriteFlags: [Flag] = flags.filter({favoritesString.contains($0.country)})
        favorites = favoriteFlags
        
    }
    
    func addToFavorites(flag: Flag) {
        favorites.append(flag)
        saveFavorites()
        objectWillChange.send()
    }
    
    func removeFromFavorites(flag: Flag) {
        favorites.removeAll(where: {$0 == flag})
        saveFavorites()
        objectWillChange.send()
    }
    
    func saveFavorites() {
        let favoritesString = favorites.map({$0.country})
        UserDefaults.standard.set(favoritesString,forKey: "favorites")
    }
    
}
