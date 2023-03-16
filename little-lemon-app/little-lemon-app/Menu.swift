//
//  Menu.swift
//  little-lemon
//
//  Created by Vasas András on 2023. 03. 16..
//

import SwiftUI
import Foundation
import CoreData

enum MenuCategories: String, CaseIterable {
    case starters
    case mains
    case desserts
    case sides
}

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText:String = ""
    @State private var selectedFilter: MenuCategories?
    @State var didAppear:Bool = false
    
    var body: some View {
        VStack{
            Header()
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack {
                    ForEach(MenuCategories.allCases, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(selectedFilter == category ? .black : .white)
                            .padding(20)
                            .background(selectedFilter == category ? Color("yellowColor") : Color("greenColor"))
                            .onTapGesture {
                                if selectedFilter == category {
                                    selectedFilter = nil
                                } else {
                                    selectedFilter = category
                                }
                            }
                            .clipShape(Capsule())
                    }
                }
            }
            .frame(maxWidth:.infinity ,maxHeight: 80)

            TextField("Search", text: $searchText)
                .padding(10)
                .frame(width: 300, height: 40)
                .background(Color(.white))
                .clipShape(Capsule())

            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) {(dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        HStack{
                            VStack{
                                Text(dish.title ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(dish.explanation ?? "" )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("$\(dish.price ?? "")")
                                    .font(.subheadline)
                                    .padding(.top)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: 75, maxHeight: 100)
                                        .cornerRadius(12)
                                case .failure:
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                @unknown default:
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                }
                            }.frame(width: 75, height: 100)
                        }
                    }
                }
            }
        }
        .background(Color("yellowColor"))
        .onAppear {
            do {try? getMenuData()}
        }
        
    }
    
    private func getMenuData() throws {
        viewContext.reset()
        PersistenceController.shared.clear()
        
        // fetch the menu data from the server
        let menuAddress = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let menuURL = URL(string: menuAddress)
        guard let menuURL = menuURL else {
            throw NSError() // if couldn't find menu address url throws error
        }
        
        let request = URLRequest(url: menuURL)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print(responseString)
                // parse the reponse data by using JSON decoder
                let decoder = JSONDecoder()
                let fullMenu = try? decoder.decode(MenuList.self, from: data) // array of MenuItems
                //print(fullMenu?.menu)
                fullMenu?.menu.forEach { menuItem in
                    let newDish = Dish(context: viewContext)
                    newDish.title = menuItem.title
                    newDish.image = menuItem.image
                    newDish.category = menuItem.category
                    newDish.explanation = menuItem.explanation
                    newDish.price = menuItem.price
                }
                try? viewContext.save()
            }
        }
        task.resume()
    }
    
    private func buildSortDescriptors() -> [NSSortDescriptor] {
            return [
                NSSortDescriptor(
                    key: "title",
                    ascending: true,
                    selector: #selector(NSString.localizedStandardCompare)
                )
            ]
        }
    
    private func buildPredicate() -> NSPredicate {
            if (selectedFilter == nil && searchText == "") {
                return NSPredicate(value: true);
            } else if (selectedFilter == nil && searchText != ""){
                return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            } else {
                return NSPredicate(format: "category == %@", selectedFilter!.rawValue)
            }
        }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
