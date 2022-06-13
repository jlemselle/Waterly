//
//  CameraButton.swift
//  Waterly
//
//  Created by James Emselle on 1/7/21.
//

import SwiftUI

struct CameraButton: View {
    @State var showCaptureImageView: Bool = false
    @Binding var image: Image?
    @Binding var uiImage: UIImage?
    
    var body: some View {
        ZStack {
            Button(
                action: { self.showCaptureImageView = true }
            ) {
                HStack {
                    Label(image == nil ? "Add photo" : "Retake photo", systemImage: "camera.fill")
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
            .fullScreenCover(isPresented: $showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image, uiImage: $uiImage)
            }
        }
    }
    
    struct CameraButton_Previews: PreviewProvider {
        static var previews: some View {
            CameraButton(image: .constant(nil), uiImage: .constant(nil))
        }
    }
}
