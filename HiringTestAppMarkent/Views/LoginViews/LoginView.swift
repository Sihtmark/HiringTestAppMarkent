//
//  LoginView.swift
//  HiringTestAppMarkent
//
//  Created by sihtmark on 29.07.2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State private var login = "atuny0"
    @State private var password = "9uQFF1Lh"
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                Capsule()
                    .fill(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .shadow(color: .black.opacity(0.15), radius: 10)
                HStack {
                    Text("Login:")
                        .foregroundColor(.accentColor)
                        .padding(.leading, 24)
                    TextField("Write your login", text: $login)
                }
                .background(.white)
                .padding(9)
            }
            ZStack {
                Capsule()
                    .fill(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .shadow(color: .black.opacity(0.15), radius: 10)
                HStack {
                    Text("Password:")
                        .foregroundColor(.accentColor)
                        .padding(.leading, 24)
                    TextField("Write your password", text: $password)
                }
                .background(.white)
                .padding(9)
            }
            Button {
                Task {
                    await vm.getUser(username: login, password: password)
                }
            } label: {
                ZStack {
                    Capsule()
                        .frame(width: 200, height: 54)
                        .cornerRadius(10)
                        .foregroundColor(.accentColor)
                        .shadow(color: .black.opacity(0.15), radius: 10)
                    Text("Checkout")
                        .font(.custom(FontTheme.instance.boldMark, size: 20))
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
