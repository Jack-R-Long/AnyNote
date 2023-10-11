//
//  CardView.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//

import SwiftUI

struct CardView: View {
    let memo: Memo
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.title)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            Label("\(memo.noteType?.rawValue ?? "N/A")", systemImage: "note")
            .font(.caption)
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var memo = Memo.sampleData[0]
    static var previews: some View {
        CardView(memo: memo)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

