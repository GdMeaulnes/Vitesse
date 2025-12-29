//
//  SearchBarView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 29/12/2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(text: .constant("test"))
}
