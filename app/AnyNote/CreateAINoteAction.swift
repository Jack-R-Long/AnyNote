//
//  SmartNoteCreate.swift
//  AnyNote
//
//  Created by Jack long on 9/24/23.
//

import MarkdownUI
import SwiftUI

struct CreateAINoteAction: View {
    @Binding var memo: Memo
    @State private var isFetching: Bool = false
    @State private var fetchError: Error? = nil

    var body: some View {
        switch memo.savedToCloudflare {
        case .unsaved:
            Text("Not saved in cloud")
        case .saving:
            Text("Saving")
        case .saved:
            Button("Create Note") {
                createNote(memoId: memo.id)
            }
                .alert(isPresented: Binding<Bool>(
                    get: { fetchError != nil },
                    set: { _ in fetchError = nil }
                )) {
                    Alert(title: Text("Error"),
                          message: Text(fetchError?.localizedDescription ?? "Unknown error"),
                          dismissButton: .default(Text("OK")))
                }
        }
    }

    func createNote(memoId: UUID) {
        isFetching = true
        CloudflareWorkerService.shared.fetchAINote(for: memo) { result in
            switch result {
            case .success(let note):
                memo.aiNote = note
            case .failure(let error):
                fetchError = error
            }
            isFetching = false
        }
    }
}

struct CreateAINoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAINoteAction(memo: .constant(Memo.sampleData[0]))
    }
}
