//
//  DetailView.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//
import MarkdownUI
import SwiftUI

struct NoteView: View {
    @Binding var memo: Memo
    @State private var isPresentingDataView = false

    var body: some View {
        VStack {
            if memo.aiNote == nil {
                CreateAINoteAction(memo: $memo)
            } else {
                Markdown(memo.aiNote ?? "no note")
                Spacer() // align to top
            }
        }
        .padding()
        .toolbar {
            NavigationLink(destination: DataView(memo: memo)) {
                Text("Settings")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteView(memo: .constant(Memo.sampleData[0]))
        }
    }
}
