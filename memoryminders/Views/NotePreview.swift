//
//  NotePreview.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI

struct NotePreview: View {
    @Binding var isEditing: Bool
    @Environment(\.managedObjectContext) var moc
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @State private var color: Color = Color.gray
    @GestureState private var fingerLocation: CGPoint?
    @GestureState private var startLocation: CGPoint? = nil
    
    var note: Note
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                note.x = Double(newLocation.x)
                note.y = Double(newLocation.y)
                self.location = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
            .onEnded { value in
                try? moc.save()
            }
    }
    
    var body: some View {
        Group {
            VStack {
                Text(note.title ?? "Unknown")
                    .font(.title)
                Divider()
                Text(note.content ?? "Unknown")
            }
        }
            .frame(width: 200, height: 200)
            .padding()
            .offset(y: -50)
            .background(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.black, lineWidth: 0.5)
            )
            .position(location)
            .gesture(
                simpleDrag
            )
            .onAppear {
                setLocation(x: note.x, y: note.y)
                setColor(hex: note.color ?? "FFFFFF")
            }
    }
    
    private func setLocation(x: Double, y: Double) {
        location = CGPoint(x: x, y: y)
    }
    
    private func setColor(hex: String) {
        color = Color(hex: hex) ?? Color.gray
    }
}

//struct NotePreview_Previews: PreviewProvider {
//    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
//    static var previews: some View {
//        NotePreview()
//    }
//}
