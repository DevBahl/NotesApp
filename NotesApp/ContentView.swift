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
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            
                            do{
                                try self.managedObjectContext.save()
                            }catch{
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                            
                        }){
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:30,height:30)
                                .foregroundColor(.green)
                        }
                    }
                } .font(.headline)
                Section(header: Text("To Do's")){
                    ForEach(self.toDoItems) {todoItem in
                    ToDoItemView(title: todoItem.title!, createdAt:"\(todoItem.createdAt!)")
                    }.onDelete{indexItem in
                        let deleteItem = self.toDoItems[indexItem.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        do{
                            try self.managedObjectContext.save()
                        }catch{
                            print(error)
                        }
                    }
               }
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
