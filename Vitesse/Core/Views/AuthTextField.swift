//
//  ViewHelper.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 23/12/2025.
//

import SwiftUI

struct AuthTextField: View {

    let systemImage: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @Binding var isValueVisible: Bool

    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(.gray)

            if isSecure && !isValueVisible {
                SecureField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }

            if isSecure {
                Button {
                    isValueVisible.toggle()
                } label: {
                    Image(systemName: isValueVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
    }
}
