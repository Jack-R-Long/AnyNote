//
//  SmartNoteCreate.swift
//  AnyNote
//
//  Created by Jack long on 9/24/23.
//

import SwiftUI

struct CreateAINoteView: View {
    @Binding var memo: Memo
    @State private var showingAlert = false
    @State private var alertTitle = "Error"
    @State private var alertMessage = "Something went wrong."
    
    
    var body: some View {
            Button("Save To Cloud") {
                saveMemo()
            }
            .disabled(memo.savedToCloudflare == .saved)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            Button("Create Note") {
                //                        createNote(memoId: memo.id)
            }
            .disabled(memo.savedToCloudflare != .saved )
    }
    
    func saveMemo() {
        CloudflareWorkerService.shared.postMemo(memo) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.memo.savedToCloudflare = .saved
                    self.alertTitle = "Success"
                    self.alertMessage = "Memo successfully saved."
                    
                case .failure(let error):
                    self.alertTitle = "Error"
                    self.alertMessage = error.localizedDescription
                }
                self.showingAlert = true
            }
        }
    }
}

struct CreateAINoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAINoteView(memo: .constant(Memo.sampleData[0]))
    }
}
