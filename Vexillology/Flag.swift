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

struct CustomList: Codable, Hashable {
    var name: String
    var flags : [Flag]
}

class Flags: ObservableObject {
    
    @Published var favorites: [Flag] = []
    let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
    var customLists: [CustomList] = []
    
    init() {
        load()
    }
    
    func reload() {
        
    }
    
    func load() {
        
        // Get the favorite flags.
        let favoritesString = UserDefaults.standard.stringArray(forKey: "favorites") ?? ["Qatar"]
        //let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
        let favoriteFlags: [Flag] = flags.filter({favoritesString.contains($0.country)})
        favorites = favoriteFlags
        
    }
    
    func addToFavorites(flag: Flag) {
        favorites.append(flag)
        saveFavorites()
        //objectWillChange.send()
    }
    
    func removeFromFavorites(flag: Flag) {
        favorites.removeAll(where: {$0 == flag})
        saveFavorites()
        //objectWillChange.send()
    }
    
    func saveFavorites() {
        let favoritesString = favorites.map({$0.country})
        UserDefaults.standard.set(favoritesString,forKey: "favorites")
    }
    
    func createCustomList(newName: String, thisFlag: Flag?) {
        if (thisFlag != nil) {
            let newList = CustomList(name: newName, flags: [thisFlag!])
            customLists.append(newList)
        } else {
            let newList = CustomList(name: newName, flags: [])
            customLists.append(newList)
        }
    }
    
}
