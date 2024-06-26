//
//  AddEmailView.swift
//  Compartz
//
//  Created by 영현 on 3/4/24.
//

import SwiftUI

struct AddEmailView: View {
    @StateObject var viewModel = RegisterationViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
//            .padding(.bottom)
            
            Text("이메일을 입력해 주세요.")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("이메일은 로그인하는 데 사용됩니다.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("Email", text: $viewModel.mail)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .autocorrectionDisabled()
            
            NavigationLink {
                CreateNameView()
            } label: {
                Text("다음")
            }
            .buttonStyle(ProductButtonStyle(width: 350, height: 44))
            .padding(.vertical)
            
            Spacer()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddEmailView()
}
