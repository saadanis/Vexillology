//
//  ContentView.swift
//  Vexillology
//
//  Created by Saad Anis on 8/10/20.
//

// 1, 2, 3.
import SwiftUI

struct ContentView: View {
    
    var favoriteFlags: [Flag] {
        
        let favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? ["Qatar"]
        let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
        let favoriteFlags: [Flag] = flags.filter({favorites.contains($0.country)})
        
        return favoriteFlags
    }
    
    @ObservedObject var flags = Flags()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Favorites")) {
                        if flags.favorites.count == 0 {
                            Label("No favorites yet", systemImage: "star")
                                .foregroundColor(.secondary)
                        }
                        else {
                            ForEach(flags.favorites, id: \.self) {
                                flag in
                                HStack {
                                    NavigationLink(destination: FlagDetailsView(flag: flag)
                                                    .environmentObject(flags)) {
                                        //                                        Image(removeSVG(img: flag.img))
                                        //                                            .resizable()
                                        //                                            .scaledToFill()
                                        //                                            .frame(width: 30, height: 30, alignment: .center)
                                        //                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                        //                                        Text(flag.country)
                                        Label(title: {
                                            Text(flag.country)
                                        }, icon: {
                                            Image(removeSVG(img: flag.img))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 30, height: 30, alignment: .center)
                                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                        })
                                    }
                                }
                            }
                        }
                    }
                    Section(header: Text("List")) {
                        NavigationLink(destination: FlagsView()
                                        .environmentObject(flags)) {
                            Label("List of Flags", systemImage: "flag")
                        }
                        ForEach(flags.customLists, id: \.self) { customList in
                            NavigationLink(destination: Text(customList.name)) {
                                Label(customList.name, systemImage: "flag")
                            }
                        }
                        Button(action: {
                            
                        }) {
                            Label("Create Custom List", systemImage: "plus")
                                .foregroundColor(.accentColor)
                        }
                    }
                    Section(header: Text("Quizzes")) {
                        NavigationLink(destination: Text("Yaa")) {
                            Label("Name the Flag", systemImage: "text.cursor")
                        }
                        NavigationLink(destination: Text("Yaa")) {
                            Label("Choose the Right Flag", systemImage: "rectangle.stack")
                        }
                    }
                    Section(header: Text("Other")) {
                        NavigationLink(destination: Text("")) {
                            Label("Principles of Flag Design", systemImage: "checkmark.seal")
                        }
                        NavigationLink(destination: Text("Yaa")) {
                            Label("Glossary", systemImage: "text.book.closed")
                        }
                        NavigationLink(destination: Text("About")) {
                            Label("About", systemImage: "info.circle")
                        }
                    }
                }
                .onAppear() {
                    flags.load()
                }
                
                .navigationBarTitle(Text("Vexillology"))
            }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
