//
//  LoadingImageFromRemoteServerView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/8/24.
//

import SwiftUI

struct LoadingImageFromRemoteServerView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the view")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    LoadingImageFromRemoteServerView()
}
