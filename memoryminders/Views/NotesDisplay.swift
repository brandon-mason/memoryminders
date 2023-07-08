//
//  NotesDisplay.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/6/23.
//

import SwiftUI
import CoreData

struct NotesDisplay: View {
    @Binding var isEditing: Bool
    var notes: FetchedResults<Note>
    @Environment(\.managedObjectContext) var moc    
    @GestureState private var scale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0
    
//    var magnification: some Gesture {
//        MagnificationGesture()
//            .updating($magnifyBy) { currentState, gestureState, transaction in
//                gestureState = currentState.magnitude
//            }
//    }
    
    var body: some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            NavigationView {
                VStack {
                    ForEach(notes, id: \.self) { note in
                        NavigationLink(destination: NoteEditor(isEditing: $isEditing, note: note)) {
                            NotePreview(isEditing: $isEditing, note: note)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
            .ignoresSafeArea(.all)
            .scaleEffect(currentScale * scale)
//            .animation(.easeInOut(duration: 0.2), value: 1.0)
            .gesture(
                MagnificationGesture()
                    .updating($scale) { value, scale, _ in
                        scale = value.magnitude
                        print(scale)
                    }
                    .onEnded { value in
                        currentScale *= value.magnitude
                    }
            )
    }
}

//struct NotesDisplay_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesDisplay()
//    }
//}
