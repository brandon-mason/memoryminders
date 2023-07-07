//
//  NotePreview.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI

struct NotePreview: View {
    @Environment(\.managedObjectContext) var moc
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @GestureState private var fingerLocation: CGPoint?
    @GestureState private var startLocation: CGPoint? = nil
    
    var note: Note
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                note.x = newLocation.x
                note.y = newLocation.y
                self.location = newLocation
            }
            .updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location // 2
            }
            .onEnded { value in
                try? moc.save()
            }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title ?? "Unknown")
                    .font(.title)
            }
            Divider()
            Text(note.content ?? "Unknown")
        }
        .frame(width: 200, height: 200)
        .padding()
        .offset(y: -50)
        .background(Color.gray)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.black, lineWidth: 5)
        )
        .position(location)
        .gesture(
            simpleDrag
        )
        .onAppear {
            setLocation(x: note.x, y: note.y)
        }
        .onTapGesture {
            print("Tapped")
        }
        
        if let fingerLocation = fingerLocation { // 5
            Circle()
                .stroke(Color.green, lineWidth: 2)
                .frame(width: 44, height: 44)
                .position(fingerLocation)
        }
    }
    
    private func setLocation(x: Double, y: Double) {
        location = CGPoint(x: x, y: y)
    }
}

//struct NotePreview_Previews: PreviewProvider {
//    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
//    static var previews: some View {
//        NotePreview()
//    }
//}
