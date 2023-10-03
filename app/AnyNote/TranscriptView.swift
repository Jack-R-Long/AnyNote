//
//  TranscriptView.swift
//  AnyNote
//
//  Created by Jack long on 9/14/23.
//

import SwiftUI

struct TranscriptView: View {
    @State private var isExpanded: Bool = false
    var transcript: String?

    var body: some View {
        VStack (alignment: .leading) {
            if transcript != nil {
                let unWrappedTranscript = transcript ?? "Error"
                if isExpanded {
                    Text(unWrappedTranscript)
                        .lineLimit(nil)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                } else {
                    Text(unWrappedTranscript)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                    HStack {
                        Spacer()
                        Text("Tap to expand")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }
            } else {
                Text("No Transcript Available")
            }
        }
    }
}

struct TranscriptView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TranscriptView(transcript: Memo.sampleData[0].transcript)
        }
    }
}
