//
//  MemoStore.swift
//  AnyNote
//
//  Created by Jack long on 9/24/23.
//

import SwiftUI

@MainActor
class MemoStore: ObservableObject {
    @Published var memos: [Memo] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("memos.data")
    }
    
    func load() async throws {
        let task = Task<[Memo], Error> {
            let fileUrl = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileUrl) else {
                return []
            }
            
            let memos = try JSONDecoder().decode([Memo].self, from: data)
            return memos
        }
        let memos = try await task.value
        self.memos = memos
    }
    
    func save(memos: [Memo] ) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(memos)
            let outFile = try Self.fileURL()
            try data.write(to: outFile)
        }
        _ = try await task.value
    }
    
}
