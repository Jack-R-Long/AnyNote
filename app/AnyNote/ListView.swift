//
//  ListView.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//

import SwiftUI

struct ListView: View {
    @State private var isRecording = false
    @Binding var memos: [Memo]

    @State private var errorPosting = false

    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void

    var body: some View {
        ZStack (alignment: .bottom) {
            NavigationStack {
                List($memos) { $memo in
                    NavigationLink(destination: DetailView(memo: $memo)) {
                        CardView(memo: memo)
                    }
                }
                .navigationTitle("Memos")
                NewRecordingButtons(isRecording: $isRecording)
            }

        }
        .sheet(isPresented: $isRecording) {
            NavigationStack {
                RecordingView(memos: $memos, errorPosting: $errorPosting)
                    .toolbar {
                        Button("Done") {
                            isRecording = false
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        // Alert for CloudFlare memo post
        .alert(isPresented: $errorPosting) {
            Alert(title: Text("Error"), message: Text("Error saving memo to cloud"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(memos: .constant(Memo.sampleData), saveAction: {})
    }
}
