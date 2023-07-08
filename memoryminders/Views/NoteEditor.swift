//
//  Note.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/6/23.
//

import SwiftUI

struct NoteEditor: View {
    @Binding var isEditing: Bool
    @Environment(\.managedObjectContext) var moc
    @State private var title: String = "Title"
    @State private var content: String = "Content"
    var note: Note
    
    var body: some View {
        VStack {
            TextEditor(text: $title)
            .onChange(of: title, perform: { value in
                note.title = value
                try? moc.save()
            })
            TextEditor(text: $content)
            .onChange(of: content, perform: { value in
                note.content = value
                try? moc.save()
            })
        }
        .onAppear {
            setTitleAndContent()
            isEditing = true
        }
        .onDisappear {
            isEditing = false
        }
    }
    
    private func setTitleAndContent() {
        title = note.title ?? "Title"
        content = note.content ?? "Content"
    }
}

//struct NoteEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteEditor()
//    }
//}
