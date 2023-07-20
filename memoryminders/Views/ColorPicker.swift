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
    @State var isLifted: Double = 500
    @Binding var isRotated: Double
    @Binding var didLongPress: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
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
                            note.jiggleDelay = Double.random(in: 0..<0.5)
                            
                            try? moc.save()
                        } label: {
                            Circle().fill(color)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                    .offset(x: 0, y: isLifted)
                    .onAppear {
                        withAnimation(.spring()
                            .speed(2).repeatCount(1)) {
                                isLifted = 0
                            }
                    }
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .rotationEffect(.degrees(isRotated))
                    .scaleEffect(CGSize(width: 3, height: 3))
                    .buttonStyle(PlainButtonStyle())
                    .onTapGesture {
                        didLongPress = false
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)
                            .speed(2).repeatCount(1)) {
                                isRotated = 45.0
                            }
                    }
            }
            .frame(maxWidth: geometry.size.width * 0.975, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}

//struct ColorPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorPicker()
//    }
//}
