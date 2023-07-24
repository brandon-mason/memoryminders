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
    @State private var isRotated = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if didLongPress {
                    ColorPicker(isRotated: $isRotated, didLongPress: $didLongPress)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                } else {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .rotationEffect(.degrees(isRotated))
                        .scaleEffect(CGSize(width: 3, height: 3))
                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: .infinity, alignment: .bottomTrailing)
                        .buttonStyle(PlainButtonStyle())
                        .onTapGesture {
                            let title = "Title"
                            let content = "Content"
                            let note = Note(context: moc)
                            note.id = UUID()
                            note.title = title
                            note.content = content
                            note.x = 100.0
                            note.y = 250.0
                            note.color = Color.gray.toHex()
                            note.jiggleDelay = Double.random(in: 0..<1.0)
                            
                            try? moc.save()
                        }
                        .simultaneousGesture(LongPressGesture(minimumDuration: 0.5).onEnded { _ in
                            didLongPress = !didLongPress
                        })
//                        .onAppear {
//                            withAnimation(.easeInOut(duration: 0.5).speed(2).repeatCount(1)) {
//                                isRotated = 0.0
//                            }
//                        }
                }
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
