//
//  AuthTextAreaView.swift
//  Vitesse
//
//  Created by Richard DOUXAMI on 29/12/2025.
//

import SwiftUI

import SwiftUI

struct AuthTextAreaView: View {
    
    let systemImage: String
    let placeholder: String
    @Binding var text: String
    
    var maxCharacters: Int = 300
    var isEditable: Bool = true
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(.gray)
                
                Text(placeholder)
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Spacer()
                
                Text("\(text.count)/\(maxCharacters)")
                    .font(.caption2)
                    .foregroundColor(text.count > maxCharacters ? .red : .gray)
            }
            
            ZStack(alignment: .topLeading) {
                
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(12)
                }
                
                TextEditor(text: $text)
                    .focused($isFocused)
                    .disabled(!isEditable)
                    .frame(minHeight: 120)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isFocused ? Color.blue : Color.gray.opacity(0.4), lineWidth: 1)
                            .background(Color(.systemGray6).cornerRadius(10))
                    )
            }
        }
        .padding(.horizontal)
        .onChange(of: text) { oldValue, newValue in
            if newValue.count > maxCharacters {
                text = String(newValue.prefix(maxCharacters))
            }
        }
    }
}

#Preview {
    AuthTextAreaView(systemImage: "text.page", placeholder: "titre", text: .constant("test"))
}
