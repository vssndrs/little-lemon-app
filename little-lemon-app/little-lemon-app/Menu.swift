//
//  Menu.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack{
            Header()
            List(){}
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
