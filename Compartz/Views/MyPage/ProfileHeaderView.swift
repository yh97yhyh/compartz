//
//  ProfileHeaderView.swift
//  Compartz
//
//  Created by 영현 on 3/2/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @EnvironmentObject var viewModel: MyPageViewModel

    var body: some View {
        VStack {
            HStack {
                ProfileImageView()
                
                VStack(alignment: .leading) {
                    Text("\(viewModel.user.nickName) 님")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(viewModel.user.mail)
                        .font(.footnote)
                    Text(viewModel.user.phone)
                        .font(.footnote)
                }
                .padding(.leading, 32)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileHeaderView()
}
