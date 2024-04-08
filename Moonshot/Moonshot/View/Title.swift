//
//  CustomTitle.swift
//  Moonshot
//
//  Created by Natalie Alvarez on 3/27/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
            .padding(.bottom, 5)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
