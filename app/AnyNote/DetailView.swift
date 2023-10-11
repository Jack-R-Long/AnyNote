//
//  DetailView.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//
import Foundation
import SwiftUI

struct DetailView: View {
    @Binding var memo: Memo
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Transcript")) {
                    TranscriptView(transcript: memo.transcript)
                }
                Section(header: Text("AI Stuff")) {
                    CreateAINoteView(memo: $memo)
                }
            }
            .navigationTitle(memo.title)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(memo: .constant(Memo.sampleData[0]))
        }
    }
}
