//
//  DisablingFormsView.swift
//  CupcakeCorner
//
//  Created by Natalie Alvarez on 4/8/24.
//

import SwiftUI

struct DisablingFormsView: View {
    @State private var username = ""
    @State private var email = ""

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating an account with username: \(username) and email: \(email)")
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    DisablingFormsView()
}
