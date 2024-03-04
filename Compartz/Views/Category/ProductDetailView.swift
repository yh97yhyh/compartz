//
//  ProductDetailView.swift
//  Compartz
//
//  Created by 영현 on 3/4/24.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductViewModel
    @State private var isModalPresented = false
    @Environment(\.dismiss) private var dismiss
    
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
                Button {
                    // cart
                } label: {
                    Image(systemName: "cart.fill")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            ScrollView {
                Image(viewModel.product.image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 250, height: 250)
                    .padding(.horizontal)
                
                Divider()
                
                Text(viewModel.product.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("\(viewModel.product.price) 원")
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                Text(viewModel.product.description)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                
                if let productImage = viewModel.product.descriptionImage {
                    Image(productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal)
                }
                
            }
            
            Button {
                isModalPresented.toggle()
            } label: {
                Text("구매하기")
            }
            .buttonStyle(ProductButtonStyle(height: 56, isMaxWidth: true))
            .sheet(isPresented: $isModalPresented) {
                ProductOrderView(viewModel: viewModel)
                    .presentationDetents([.height(80)])
            }
        }
        .setTabBarVisibility(isHidden: true)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ProductButtonStyle: ButtonStyle {
    let width: CGFloat?
    let height: CGFloat
    let isMaxWidth: Bool

    init(width: CGFloat? = nil, height: CGFloat = 32, isMaxWidth: Bool = false) {
        self.width = width
        self.height = height
        self.isMaxWidth = isMaxWidth
    }

    func makeBody(configuration: Configuration) -> some View {
        if isMaxWidth {
            configuration.label
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundColor(.black)
                .overlay(
                    Rectangle()
                        .stroke(.gray, lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        } else {
            configuration.label
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: width, height: height)
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}


#Preview {
    ProductDetailView(viewModel: ProductViewModel())
}