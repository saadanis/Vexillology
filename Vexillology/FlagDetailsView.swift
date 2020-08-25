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
    
    @State private var showingSheet = false
    
    @State var newName: String = ""
    
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
            .sheet(isPresented: $showingSheet, content: {
                NavigationView {
                    Form {
                        TextField("Name", text: $newName)
                    }
                    .navigationBarTitle(Text("Create New List"))
                    .navigationBarItems(leading: Button("Cancel") {
                        showingSheet = false
                    }, trailing: Button("Create") {
                        flags.createCustomList(newName: newName, thisFlag: flag)
                    })
                }
            })
        }
        .navigationBarTitle(Text(flag.country))
        .navigationBarItems(trailing: HStack {
            Menu {
                Button(action: {
                    showingSheet = true
                }) {
                    Label("Create new list", systemImage: "plus")
                }
                ForEach(1..<5){ num in
                    Button("Butotn \(num)", action: {})
                }
                Button("Cancel", action: {})
            } label: {Label("Add to List", systemImage: "plus")}
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
