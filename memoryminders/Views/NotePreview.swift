//
//  NotePreview.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/3/23.
//

import SwiftUI

struct NotePreview: View {
    @Binding var isEditing: Bool
    @Binding var movingNotes: Bool
    @Environment(\.managedObjectContext) var moc
    @State private var location: CGPoint = CGPoint(x: 0.0, y: 0.0)
    @State private var color: Color = Color.gray
    @State private var isRotating: Double = 5.0
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
        if movingNotes {
            ZStack {
                Group {
                    VStack {
                        Text(note.title ?? "Unknown")
                            .font(Font.system(size: 10))
                        Divider()
                        Text(note.content ?? "Unknown")
                            .font(Font.system(size: 8))
                        Text(String(note.x))
                            .font(Font.system(size: 8))
                        Text(String(note.y))
                            .font(Font.system(size: 8))
                    }
                }
                .frame(width: 50, height: 50)
                .padding()
                .offset(y: -15)
                .background(color)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(.black, lineWidth: 0.5)
                )
                .rotationEffect(.degrees(isRotating))
                .position(location)
                .gesture(
                    simpleDrag
                )
                Image(systemName: "plus.circle.fill")
                    .rotationEffect(.degrees(45.0))
                //                .buttonStyle(PlainButtonStyle())
                    .position(x: location.x + 40, y: location.y - 35)
                    .onTapGesture {
                        do {
                            moc.delete(note)
                            try moc.save()
                        } catch {
                            
                        }
                    }
            }
            .onAppear {
                setLocation(x: note.x, y: note.y)
                setColor(hex: note.color ?? "FFFFFF")
                withAnimation(.easeInOut(duration: 1).speed(6).repeatForever(autoreverses: true)) {
                    isRotating = -5
                }
            }
            .onDisappear {
                withAnimation {
                    isRotating = 0.0
                }
            }
        } else {
            ZStack {
                Group {
                    VStack {
                        Text(note.title ?? "Unknown")
                            .font(Font.system(size: 10))
                        Divider()
                        Text(note.content ?? "Unknown")
                            .font(Font.system(size: 8))
                        Text(String(note.x))
                            .font(Font.system(size: 8))
                        Text(String(note.y))
                            .font(Font.system(size: 8))
                    }
                }
                .frame(width: 50, height: 50)
                .padding()
                .offset(y: -15)
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
                .gesture(LongPressGesture(minimumDuration: 1.0).onEnded { _ in
                    movingNotes = true
                })
            }
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
//
//    static var previews: some View {
//        NotePreview(isEditing: .constant(false), note: exampleNote)
//    }
//}
