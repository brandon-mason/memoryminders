//
//  ColorPicker.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/7/23.
//

import SwiftUI

struct ColorPicker: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var usedColors: FetchedResults<UsedColors>
    @State private var noteColor: Color = Color.gray
    @Binding var didLongPress: Bool

    var body: some View {
        SwiftUI.ColorPicker("", selection: $noteColor, supportsOpacity: false)
            .scaleEffect(CGSize(width: 2, height: 2))
            .labelsHidden()
            .onChange(of: noteColor) { tag in
                print(noteColor)
                let usedColor = UsedColors(context: moc)
                usedColor.usedColor = noteColor.toHex()
                
                try? moc.save()
            }
        ForEach(usedColors.suffix(4), id: \.self) { usedColor in
            let color = Color(hex: usedColor.usedColor ?? "8E8E93") ?? Color.gray
            Button() {
                let title = "Title"
                let content = "Content"
                let note = Note(context: moc)
                note.id = UUID()
                note.title = title
                note.content = content
                note.x = 100.0
                note.y = 250.0
                note.color = usedColor.usedColor
                
                try? moc.save()
            } label: {
                Circle().fill(color)
                    .frame(width: 100, height: 100)
            }
        }
//        Button() {
//            let title = "Title"
//            let content = "Content"
//            let note = Note(context: moc)
//            note.id = UUID()
//            note.title = title
//            note.content = content
//            note.x = 100.0
//            note.y = 250.0
//            note.color = Color.blue.toHex()
//            
//            try? moc.save()
//        } label: {
//            Circle().fill(Color.blue)
//                .frame(width: 100, height: 100)
//        }
//        Button() {
//            let title = "Title"
//            let content = "Content"
//            let note = Note(context: moc)
//            note.id = UUID()
//            note.title = title
//            note.content = content
//            note.x = 100.0
//            note.y = 250.0
//            note.color = Color.red.toHex()
//            
//            try? moc.save()
//        } label: {
//            Circle().fill(Color.red)
//                .frame(width: 100, height: 100)
//        }
//        Button() {
//            let title = "Title"
//            let content = "Content"
//            let note = Note(context: moc)
//            note.id = UUID()
//            note.title = title
//            note.content = content
//            note.x = 100.0
//            note.y = 250.0
//            note.color = Color.yellow.toHex()
//            
//            try? moc.save()
//        } label: {
//            Circle().fill(Color.yellow)
//                .frame(width: 100, height: 100)
//        }
        Image(systemName: "plus.circle.fill")
            .font(.largeTitle)
            .rotationEffect(.degrees(45))
            .scaleEffect(CGSize(width: 3, height: 3))
            .buttonStyle(PlainButtonStyle())
            .onTapGesture {
                didLongPress = false
            }
    }
}

//struct ColorPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorPicker()
//    }
//}
