//
//  UserProfile.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import SwiftUI

let firstName = UserDefaults.standard.string(forKey: kFirstName)
let lastName = UserDefaults.standard.string(forKey: kLastName)
let email = UserDefaults.standard.string(forKey: kEmail)
struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        VStack{
            Text("Personal information")
                .padding(.bottom)
                .frame(maxWidth: .infinity)
                .font(.largeTitle)
                .foregroundColor(Color("yellowColor"))
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("greenColor")/*@END_MENU_TOKEN@*/)
            Image("Profile")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .background(Color(.white))
                .padding(.vertical, 20.0)

            Text("First name:")
            Text(firstName ?? "")
                .frame(width: 300, height: 60)
                .background(Color(.white))
                .clipShape(Capsule())
            Text("Last name:")
            Text(lastName ?? "")
                .frame(width: 300, height: 60)
                .background(Color(.white))
                .clipShape(Capsule())
            Text("Email:")
            Text(email ?? "")
                .frame(width: 300, height: 60)
                .background(Color(.white))
                .clipShape(Capsule())
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            }
            .frame(width: 300, height: 60)
                .foregroundColor(Color(.white))
                .background(Color("greenColor"))
                .clipShape(Capsule())
                .padding(.top, 20.0)
            Spacer()

        }
        .frame(maxWidth: .infinity)
        .background(Color("yellowColor"))
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
