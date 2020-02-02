//
//  ContentView.swift
//  NotesApp
//
//  Created by Dev Bahl on 02/02/20.
//  Copyright © 2020 Dev Bahl. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("What's Next?")){
                    HStack{
                        TextField("New Item", text: $newToDoItem)
                        Button(action:{
                            
                        }){
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30,height:30)
                                .foregroundColor(.green)
                        }
                    }
                }.font(.headline)
            }
            .navigationBarTitle(Text("My Notes"))
            .navigationBarItems(trailing: EditButton())
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
