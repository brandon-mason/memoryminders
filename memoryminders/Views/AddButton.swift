//
//  SwiftUIView.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI

struct AddButton: View {
    @Environment(\.managedObjectContext) var moc
    @State private var didTap: Bool = false
    @State private var didLongPress: Bool = false
    
    var body: some View {
        Button() {
            let title = "Title"
            let content = "Content"
            let note = Note(context: moc)
            print(note)
            note.id = UUID()
            note.title = title
            note.content = content
            note.x = 0.0
            note.y = 0.0
            
            try? moc.save()
        } label: {
            VStack {
                Image(systemName: "plus.circle.fill")
            }
            .font(.largeTitle)
        }
        .buttonStyle(PlainButtonStyle())
        .controlSize(.large)
        .onLongPressGesture {
            didLongPress = true
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
