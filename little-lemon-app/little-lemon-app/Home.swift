//
//  Home.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView{
            Menu()
                .tabItem({Label("Menu", systemImage: "list.dash")})
            UserProfile()
                .tabItem({Label("Profile", systemImage: "square.and.pencil")})
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
