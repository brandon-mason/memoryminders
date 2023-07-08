//
//  ContentView.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isEditing: Bool = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    
    var body: some View {
        ZStack {
            NotesDisplay(isEditing: $isEditing, notes: notes)
            if !isEditing {
                AddButton()
                Button("Delete") {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                    
                    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    
                    do {
                        print("Deleted All")
                        try moc.execute(batchDeleteRequest)
                        
                    } catch {
                        // Error Handling
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
