//
//  Header.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack{
            Image("Logo")
                .frame(maxWidth: .infinity)
                .background(Color(.white))
            Text("Little lemon")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("yellowColor"))
                .multilineTextAlignment(.leading)
                .padding(10)
            Text("Chicago")
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.leading, 10)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .font(.body)
                .foregroundColor(Color(.white))
                .multilineTextAlignment(.center)
                .padding(10)
        }
        .background(Color("greenColor"))
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
