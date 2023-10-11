//
//  DataView.swift
//  AnyNote
//
//  Created by Jack long on 10/10/23.
//

import SwiftUI

struct DataView: View {
    var memo: Memo
    var body: some View {
        VStack {
            List {
                Section(header: Text("AI Stuff")) {
                    HStack {
                        Label("Model", systemImage: "apple.terminal")
                        Spacer()
                        Text("GPT-4")
                    }
                }
                Section(header: Text("Recording")) {
                    HStack {
                        Label("Date", systemImage: "calendar")
                        Spacer()
                        Text(memo.date, style: .date)                    }
                    TranscriptView(transcript: memo.transcript)
                }
//                Section(header: Text("Note")) {
//                    Text(memo.aiNote ?? "No note")
//                }
            }
        }
        .navigationTitle(memo.title)
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DataView(memo: Memo.sampleData[0])
        }
    }
}
