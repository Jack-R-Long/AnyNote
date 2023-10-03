//
//  NewRecordingButtons.swift
//  AnyNote
//
//  Created by Jack long on 9/30/23.
//

import SwiftUI

struct NewRecordingButtons: View {
    @Binding var isRecording: Bool
    var body: some View {
        HStack(spacing: 50) {
            Button(action: {
                // Action for audio recording
                isRecording = true
            }) {
                Image(systemName: "mic")
                    .imageScale(.large)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }

            Button(action: {
                // Action for taking a picture
                print("Camera activated")
            }) {
                Image(systemName: "camera")
                    .imageScale(.large)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.8))
    }
}

struct NewRecordingButtons_Previews: PreviewProvider {
    static var previews: some View {
        NewRecordingButtons(isRecording: .constant(false))
    }
}
