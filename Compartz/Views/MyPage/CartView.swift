//
//  CartView.swift
//  Compartz
//
//  Created by 영현 on 3/4/24.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel = MyPageViewModel.shared
    @Environment(\.dismiss) private var dismiss
    @State var isAll = false
    
    var selectedItemCount: Int {
        viewModel.cartItems.filter { $0.selected }.count
    }
    
    var totalPrice: Int {
        var sum = 0
        for cartItem in viewModel.cartItems {
            if cartItem.selected {
                sum += cartItem.product.price * cartItem.count
            }
        }
        return sum
    }

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
                
                Text("장바구니")
                    .font(.headline)
                
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Toggle("전체선택", isOn: $isAll)
                    .toggleStyle(CheckboxStyle())
                
                Text("(\(selectedItemCount) / \(viewModel.cartItems.count))")
                
                Spacer()
                
                Button("선택삭제") {
                    print("click")
                }
                .buttonStyle(FilterButtonStyle())
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
            
            ScrollView {
                ForEach(viewModel.cartItems.indices, id: \.self) { index in
                    CartCardView(viewModel: CartViewModel(viewModel.cartItems[index]),
                                 isSelected: $viewModel.cartItems[index].selected,
                                 count: $viewModel.cartItems[index].count, 
                                 index: index)
                    Divider()
                }
            }
            
            Button {
                print("click")
            } label: {
                Text("총 \(totalPrice)원 결제하기")
            }
            .buttonStyle(ProductButtonStyle(height: 56, isMaxWidth: true))
        }
        .setTabBarVisibility(isHidden: true)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .black : .gray)
//                .font(.system(size: 20, weight: .regular, design: .default))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}

#Preview {
    CartView()
}