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
    @State private var scale: CGFloat = 1.0
    @State private var currentScale: CGFloat = 1.0
    @State private var movingNotes: Bool = false
    @State private var isRotating = 0.0
    @GestureState private var gestureScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                if(!movingNotes) {
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        ZStack {
                            Group {
                                ForEach(notes, id: \.self) { note in
                                    NavigationLink(destination: NoteEditor(isEditing: $isEditing, note: note)) {
                                        NotePreview(isEditing: $isEditing, movingNotes: $movingNotes, note: note)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    //                                    .rotationEffect(.degrees(isRotating))
                                }
                            }
                            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(scale * currentScale * gestureScale)
                    .gesture(MagnificationGesture()
                        .updating($gestureScale) { value, gestureScale, _ in
                            gestureScale = value.magnitude
                        }
                        .onEnded { value in
                            let newScale = currentScale * value.magnitude
                            currentScale = newScale > 1.0 ? newScale : 1.0
                        }
                    )
                } else {
                    Group {
                        ZStack {
                            Button(action: {
                                movingNotes = false
                                print("movingNotes", movingNotes)
                            }) {
                                Color.clear
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            Group {
                                ForEach(notes, id: \.self) { note in
                                    NavigationLink(destination: NoteEditor(isEditing: $isEditing, note: note)) {
                                        NotePreview(isEditing: $isEditing, movingNotes: $movingNotes, note: note)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(scale * currentScale * gestureScale)
                    .gesture(MagnificationGesture()
                        .updating($gestureScale) { value, gestureScale, _ in
                            gestureScale = value.magnitude
                        }
                        .onEnded { value in
                            let newScale = currentScale * value.magnitude
                            currentScale = newScale > 1.0 ? newScale : 1.0
                        }
                    )
                }
            }
        }
    }
}
