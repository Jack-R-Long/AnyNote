//
//  RecordingAnimation.swift
//  AnyNote
//
//  Created by Jack long on 9/7/23.
//

import SwiftUI

struct RecordingAnimation: View {
    let isRecording: Bool
    var body: some View {
        if (isRecording) {
            Text("Recording")
        } else {
            Text("Not Recording")
        }
    }
}

struct RecordingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RecordingAnimation(isRecording: true)
    }
}
