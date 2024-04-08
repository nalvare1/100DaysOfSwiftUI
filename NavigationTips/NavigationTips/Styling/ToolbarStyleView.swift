//
//  ToolbarStyleView.swift
//  NavigationTips
//
//  Created by Natalie Alvarez on 4/2/24.
//

import SwiftUI

struct ToolbarStyleView: View {
    var body: some View {
        NavigationStack {
            Text("Hello world")
                .toolbar {
                    // Option 1:
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // button action code
                        }
                    }

                    ToolbarItem(placement: .topBarLeading) {
                        Button("Or Tap Me") {
                            // button action code
                        }
                    }

                    // or Option 2 - both produce the same result:
                    /*
                     ToolbarItemGroup(placement: .topBarLeading) {
                         Button("Tap Me") {
                             // button action code
                         }

                         Button("Or Tap Me") {
                             // button action code
                         }
                     }
                     */
                }
                //.navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ToolbarStyleView()
}
