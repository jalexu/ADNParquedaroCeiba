//
//  CircleImageView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 30/03/23.
//

import SwiftUI

struct CircleImageView: View {
    private var imageName: String = ""
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.orange, lineWidth: 8))
            .frame(width: 190, height: 190)
            .padding(.top, 20)
            .padding(.bottom, 8)
    }
}

#if DEBUG
struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(imageName: "vehicle")
    }
}
#endif
