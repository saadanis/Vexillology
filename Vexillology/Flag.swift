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

class Flags {
    let urlString = "./countriesjson.json"
    var flags: [Flag] = []
    
    init() {
        load()
    }
    
    func load() {
        print("starting load.")
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print("1")
                parse(json: data)
            }
        }
        print("ending load.")
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonFlags = try? decoder.decode([Flag].self, from: json) {
            flags = jsonFlags
        }
    }
}
