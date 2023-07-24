//
//  SwiftUIView.swift
//  memoryminders
//
//  Created by Brandon Marquez on 7/24/23.
//

import SwiftUI

struct NoteContent: View {
    var note: Note
    @State private var title: String = ""
    @State private var content: String = ""

    var body: some View {
        VStack {
            Text(title)
                .font(Font.system(size: 10))
            Divider()
            Text(content)
                .font(Font.system(size: 8))
        }
        .onAppear {
            makeTitle(title: note.title ?? "Unknown")
            makeContent(content: note.title ?? "Unknown")
        }
    }
    
    private func makeTitle(title: String) {
        title.count > 16 ? (title[title.index(title.startIndex, offsetBy: 0)..<title.index(title.startIndex, offsetBy: 16)]) + "..." : title
    }
    
    private func makeContent(content: String) {
        content.count > 32 ? (content[content.index(content.startIndex, offsetBy: 0)..<content.index(content.startIndex, offsetBy: 32)]) + "..." : content
    }
}

//struct NoteContent_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteContent()
//    }
//}
