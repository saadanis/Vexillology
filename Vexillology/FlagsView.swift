//
//  FlagsView.swift
//  Vexillology
//
//  Created by Saad Anis on 2020.08.16.
//

import SwiftUI

struct FlagsView: View {
    
    let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
    
    var favoriteFlags: [Flag] {
        
        let favorites = UserDefaults.standard.stringArray(forKey: "favorites") ?? ["Afghanistan","Qatar"]
        let flags: [Flag] = Bundle.main.decode([Flag].self, from: "countriesjson.json")
        let favoriteFlags: [Flag] = flags.filter({favorites.contains($0.country)})
        
        return favoriteFlags
    }
    
    @EnvironmentObject var flagsFavorite: Flags
    
    var body: some View {
        VStack {
            List {
                ForEach(flags, id: \.self) { flag in
                    HStack {
                        NavigationLink(destination: FlagDetailsView(flag: flag).environmentObject(flagsFavorite)) {
                            //                                Image(removeSVG(img: flag.img))
                            //                                    .resizable()
                            //                                    .scaledToFill()
                            //                                    .frame(width: 30, height: 30, alignment: .center)
                            //                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            //                            RoundedRectangle(cornerRadius: 25)
                            //                                .background(Image(removeSVG(img: flag.img)))
                            //                                Text(flag.country)
                            Label(
                                title: { Text(flag.country) },
                                icon: { Image(removeSVG(img: flag.img))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .clipShape(RoundedRectangle(cornerRadius: 5)) }
                            )
//                            .layoutPriority(2)
//                            Spacer()
//                                .layoutPriority(0)
//                            Button(action: {}) {
//                                Image(systemName: isCountryFavorite(flag: flag) ? "star.fill" : "star")
//                                    .foregroundColor(.accentColor)
//                            }
//                            .buttonStyle(BorderlessButtonStyle())
                        }
                        //                        Label(title: {Text(flag.country)}, icon: {Image(removeSVG(img: flag.img))
                        //                                .resizable()
                        //                                .scaledToFill()
                        //                                .frame(width: 30, height: 30, alignment: .center)
                        //                                .clipShape(Circle())})
                    }
                }
            }
        }
        .navigationBarTitle(Text("List of Flags"))
        .navigationBarItems(trailing: Button(action: {
            
        }){
            Image(systemName: "ellipsis.circle")
        })
        
    }
    
    func isCountryFavorite(flag: Flag) -> Bool {
        if favoriteFlags.contains(flag) { return true }
        return false
    }
    
    func scaleFactor(geometry: GeometryProxy, imageGeometry: GeometryProxy) -> CGFloat {
        let imagePosition = imageGeometry.frame(in: .global).minY
        let safeAreaHeight = geometry.safeAreaInsets.top
        
        return (safeAreaHeight - imagePosition) / 500
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

struct FlagsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView()
    }
}
