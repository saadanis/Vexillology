//
//  FlagDetailsView.swift
//  Vexillology
//
//  Created by Saad Anis on 2020.08.17.
//

import SwiftUI

struct FlagDetailsView: View {
    
    let flag: Flag
    
    @EnvironmentObject var flags: Flags
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Image(removeSVG(img: flag.img))
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 15)
                Text(flag.country)
                    .font(.title)
                HStack {
                    if flag.name != "" {
                        Label(flag.name, systemImage: "flag")
                        Spacer()
                    }
                    if flag.adopted != "" {
                        Label(flag.adopted, systemImage: "calendar")
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(Text(flag.country))
        .navigationBarItems(trailing: HStack {
            Button(action: {}){
                Image(systemName: "plus")
            }
            Button(action: {
                if isFavorite() {
                    flags.removeFromFavorites(flag: flag)
                } else {
                    flags.addToFavorites(flag: flag)
                }
            }){
                Image(systemName: isFavorite() ? "star.fill" : "star")
            }
        })
    }
    
    func isFavorite() -> Bool {
        if flags.favorites.contains(flag) {
            return true
        }
        return false
    }
    
    func removeSVG(img: String) -> String {
        var components = img.components(separatedBy: ".")
        if components.count > 1 { // If there is a file extension
            components.removeLast()
            return components.joined(separator: ".")
        } else {
            return img
        }
    }
    
}

struct FlagDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagDetailsView(flag: Flag(country: "United Kingdom", name: "Union Jack", img: "gb.svg", adopted: "1801", continent: "Europe"))
    }
}
