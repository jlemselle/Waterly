//
//  Editor.swift
//  Waterly
//
//  Created by James Emselle on 1/7/21.
//

import SwiftUI

struct Editor: View {
    @Binding var date: Date
    let saving: () -> Void
    let cancel: () -> Void
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    @Binding var comment: String
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        VStack {
            DatePicker("Watered on", selection: $date, in: ...Date.now)
                .padding()
            
            TextField("Comment", text: $comment)
                .padding()
            
            CameraButton(image: $image, uiImage: $uiImage)
            
            image?.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
            Divider()
            HStack {
                Button("Save") {
                    saving()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8)
                Button("Cancel") {
                    cancel()
                }
                .padding()
            }
        }
    }
}

struct Editor_Previews: PreviewProvider {
    static var previews: some View {
        Editor(date: .constant(Date()), saving: {}, cancel: {}, image: .constant(nil), uiImage: .constant(nil), comment: .constant(""))
    }
}
