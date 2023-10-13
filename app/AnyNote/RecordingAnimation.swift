//
//  RecordingAnimation.swift
//  AnyNote
//
//  Created by Jack long on 9/7/23.
//

import SwiftUI

struct RecordingAnimation: View {
    @State private var wave = false
    let isRecording: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 40)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .foregroundColor(.blue)
                .scaleEffect(wave ? 2 : 1)
                .opacity(wave ? 0.1 : 1)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).speed(0.5), value: wave)

            Circle()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .shadow(radius: 25)
            Image(systemName: "mic.circle.fill")
                .font(.system(size: 90))
                .foregroundColor(.white)
                .shadow(radius: 25)
        }
        .onAppear() {
            self.wave.toggle()
        }
    }
}

struct RecordingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RecordingAnimation(isRecording: true)
    }
}
