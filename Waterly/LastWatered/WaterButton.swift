//
//  WaterButton.swift
//  Waterly
//
//  Created by James Emselle on 1/7/21.
//

import SwiftUI

struct WaterButton: View {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Text("Water")
                Image(systemName: "drop.fill")
            }
        })
        .padding()
        .background(Color.blue)
        .clipShape(Capsule())
        .foregroundColor(.white)
        .font(.title)
    }
}

struct WaterButton_Previews: PreviewProvider {
    static var previews: some View {
        WaterButton(action: {})
    }
}
