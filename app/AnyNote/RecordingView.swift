//
//  RecordingView.swift
//  AnyNote
//
//  Created by Jack long on 8/22/23.
//

import SwiftUI

struct RecordingView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    @Binding var memos: [Memo]
    @Binding var errorPosting: Bool


    var body: some View {
        VStack {
            RecordingAnimation(isRecording: isRecording)
        }
        .onAppear {
            startRecording()
        }
        .onDisappear {
            stopRecording()
        }
    }

    private func startRecording() {
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
    }

    private func stopRecording() {
        speechRecognizer.stopTranscribing()
        isRecording = false

        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = formatter.string(from: currentDate)

        let newMemo = Memo(title: currentDateString, transcript: speechRecognizer.transcript)
        memos.append(newMemo)

        // Call the CloudflareWorkerService to post the new memo
        CloudflareWorkerService.shared.postMemo(newMemo) { result in
            switch result {
            case .success:
                print("Memo successfully posted.")
                
                // Find the index of the memo you've just added
                if let index = self.memos.firstIndex(where: { $0.id == newMemo.id }) {
                    // Modify the memo's savedToCloudflare status
                    self.memos[index].savedToCloudflare = .saved
                    
                    // [Optional] Save the updated memos
                    // try? self?.save(memos: self?.memos ?? [])
                }
            
            // TODO - test error handling / notification
            case .failure(let error):
                print("Error posting: \(error)")
                errorPosting = true
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RecordingView(memos: .constant(Memo.sampleData), errorPosting: .constant(false))
        }
    }
}
