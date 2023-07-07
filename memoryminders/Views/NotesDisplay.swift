//
//  NotesDisplay.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/6/23.
//

import SwiftUI
import CoreData

struct NotesDisplay: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
    var body: some View {
        ZStack {
            NavigationView {
                GroupBox {
                    ForEach(notes, id: \.self) { note in
                        NavigationLink {
                            NoteEditor(note: note)
                        } label: {
                            NotePreview(note: note)
                                .offset(x: CGFloat(note.x), y: CGFloat(note.y))
                        }
                    }
                }
            }
            Group {
                AddButton()
                Button("Delete") {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")

                    // Create Batch Delete Request
                    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                    do {
                        print("Deleted All")
                        try moc.execute(batchDeleteRequest)

                    } catch {
                        // Error Handling
                    }
                }.offset(y: -100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
//        .padding()
    }
}

struct NotesDisplay_Previews: PreviewProvider {
    static var previews: some View {
        NotesDisplay()
    }
}
