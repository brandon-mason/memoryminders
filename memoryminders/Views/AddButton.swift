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
        VStack {
            if didLongPress {
                ColorPicker(didLongPress: $didLongPress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            } else {
                Image(systemName: "plus.circle.fill")
                    .scaleEffect(CGSize(width: 3, height: 3))
                    .onTapGesture {
                        print("Added")
                        let title = "Title"
                        let content = "Content"
                        let note = Note(context: moc)
                        note.id = UUID()
                        note.title = title
                        note.content = content
                        note.x = 100.0
                        note.y = 250.0
                        note.color = Color.gray.toHex()
                        
                        try? moc.save()
                    }
                    .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                        didLongPress = !didLongPress
                        print("didLongPress")
                    })
                    .font(.largeTitle)
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                //                .controlSize(.large)
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
