//
//  HistoryItem.swift
//  Waterly
//
//  Created by James Emselle on 30/6/21.
//

import SwiftUI

struct HistoryItem: View {
    var timestamp: Date
    var comment: String
    var image: UIImage?
    
    @State var zoomImage: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(timestamp, style: .date)
                Text("at")
                Text(timestamp, style: .time)
                Spacer()
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            zoomImage.toggle()
                        }
                        .sheet(isPresented: $zoomImage) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                } else {
                    Image(systemName: "drop")
                }
            }
            Text(comment)
                .font(.caption)
        }
        .padding()
    }
}

struct HistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItem(timestamp: Date(), comment: "Example comment")
    }
}
