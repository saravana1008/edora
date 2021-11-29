//
//  FloatingTextField.swift
//  Edvora
//
//  Created by Saravanakumar Balasubramanian on 29/11/21.
//

import SwiftUI

struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    private let placeHolderImage: String
    private let rightSideImage: String?
    
    @Binding var text: String
    @State private var isEditing = false
    @State private var isSecured = true
    @FocusState private var isFocused: Bool
    
    public init(placeHolder: String, placeHolderImage: String,
                text: Binding<String>, rightSideImage: String? = nil) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderImage = placeHolderImage
        self.rightSideImage = rightSideImage
    }
    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(placeHolderImage)
                    .resizable()
                    .frame(width: 25, height: 25, alignment: .center)
                if rightSideImage == nil || !isSecured {
                    TextField("", text: $text, onEditingChanged: { (edit) in
                        isEditing = edit
                    })
                        .focused($isFocused)
                } else {
                    SecureField("", text: $text, onCommit: { isEditing = false })
                        .onTapGesture {
                                isEditing = true
                        }
                        .focused($isFocused)
                        .border(Color(hex: isEditing ? "#FAFAFA" : "#F0F0F0"), width: 1)
                }
                if let rightHolderImage = rightSideImage  {
                    Image(rightHolderImage)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .onTapGesture {
                            isSecured.toggle()
                        }
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: isEditing ? "#BF9B9B" : "#FAFAFA"), lineWidth: 1)
                        .frame(height: textFieldHeight))
            .foregroundColor(Color.primary)
            .accentColor(Color.secondary)
            .background(Color(hex: "#FAFAFA"))
            Text(placeHolderText)
            .background(Color(hex: "#FAFAFA"))
            .foregroundColor(Color.secondary)
                .background(Color(UIColor.systemBackground))
            .padding(EdgeInsets(top: 0, leading:15, bottom: textFieldHeight, trailing: 0))
            .scaleEffect(1.0)
            .onTapGesture {
                if !isEditing {
                    isEditing = true
                    isFocused = true
                }
            }
        }
    }
}

