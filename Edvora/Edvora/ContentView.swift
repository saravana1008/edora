//
//  ContentView.swift
//  Edvora
//
//  Created by Saravanakumar Balasubramanian on 28/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var userName: String
    @State var password: String
    @State var email: String
    
    @State private var showAlert = false
    @State var errMsg = ""
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Spacer()
                Image("EdvoraIcon")
                    .aspectRatio(1, contentMode: .fit)
                Spacer()
            }
            Spacer().frame(height: 108)
            VStack(alignment: .leading, spacing: 26) {
                FloatingTextField(placeHolder: "Name", placeHolderImage: "UserIcon", text: $userName)
                    .autocapitalization(.none)
                FloatingTextField(placeHolder: "Password", placeHolderImage: "PasswordIcon", text: $password, rightSideImage: "EyeIcon")
                FloatingTextField(placeHolder: "Email address", placeHolderImage: "EmailIcon", text: $email)
            }
            Button(action: {}) {
                Text("Forgotten password?")
                    .foregroundColor(Color(hex: "#BF9B9B"))
            }
            .frame(minWidth: 0, maxWidth: 250, minHeight:0, maxHeight: 20, alignment: Alignment.trailing)
            .padding(.trailing, 0)
            Spacer().frame(height: 60)
            HStack {
                Spacer()
                Button(action: {
                    validateInputDetails()
                }) {
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .frame(width: 302, height: 52)
                        .background(Color(hex: "#733D47"))
                        .cornerRadius(13.0)
                }
                Spacer()
            }
            Spacer().frame(height: 30)
            HStack {
                Spacer()
                Text("Don't have an account? Sign up")
                    .foregroundColor(Color(hex: "#959595"))
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 74)
        .padding([.leading, .trailing], 36)
        .alert(errMsg, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                showAlert = false
                self.errMsg = ""
            }
        }
    }
    
    private func validateInputDetails() {
        if userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errMsg = "Please enter user name"
        } else if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errMsg = "Please enter password"
        } else if email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            errMsg = "Please enter email"
        } else if !email.isValidatorEmail() {
            errMsg = "Please enter valid email"
        } else if !password.isValidPassword() {
            errMsg = "Please enter valid password"
        } else if !userName.isValidUserName() {
            errMsg = "Please enter valid username"
        }
        if !errMsg.isEmpty {
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userName: "sample", password: "", email: "")
    }
}
