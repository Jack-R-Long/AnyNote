//
//  AnyNoteApp.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//

import SwiftUI

@main
struct AnyNoteApp: App {
    @StateObject private var store = MemoStore()
    @State private var errorWrapper: ErrorWrapper?
 
    var body: some Scene {
        WindowGroup {
            ListView(memos: $store.memos) {
                Task {
                    do {
                        try await store.save(memos: store.memos)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "AnyNote will load sample data and continue")
                }
            }
            .sheet(item: $errorWrapper) {
                store.memos = Memo.sampleData
                
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
