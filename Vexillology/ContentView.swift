//
//  ContentView.swift
//  Vexillology
//
//  Created by Saad Anis on 8/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var favorites: [String] = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Favorites")) {
                        if favorites.count == 0 {
                            Label("No favorites yet", systemImage: "star")
                                .foregroundColor(.secondary)
                        }
                        else {
                            
                        }
                    }
                    Section(header: Text("List")) {
                        NavigationLink(destination: FlagsView()) {
                            Label("List of Flags", systemImage: "flag")
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
                
                .navigationBarTitle(Text("Vexillology"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
