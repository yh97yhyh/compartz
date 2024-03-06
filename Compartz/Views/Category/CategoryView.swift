//
//  CategoryView.swift
//  Compartz
//
//  Created by 영현 on 3/2/24.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = CategoryViewModel.shared
    @State private var selectedCategory: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                //                    Button {
                //                        // back
                //                    } label: {
                //                        Image(systemName: "chevron.backward")
                //                            .imageScale(.large)
                //                            .foregroundColor(.black)
                //                    }
                Text("Compartz")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: CartView()) {
                    Image(systemName: "cart.fill")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        HStack(spacing: 20) {
                            Button("전체") {
                                withAnimation {
                                    selectedCategory = 0
                                    scrollProxy.scrollTo(0, anchor: .center)
                                }
                            }
                            .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == 0))
                            .id(0)
                            ForEach(viewModel.categories, id: \.self) { category in
                                Button(category.name) {
                                    withAnimation {
                                        selectedCategory = category.id
                                        scrollProxy.scrollTo(selectedCategory, anchor: .center)
                                    }
                                }
                                .buttonStyle(CategoryButtonStyle(isSelected: selectedCategory == category.id))
                                .id(category.id)
                            }
                        }
                        
                    }
                    .padding()
                }
                .onChange(of: selectedCategory) { newCategory in
                    let scrollToCategoryID = newCategory == 0 ? 0 : viewModel.categories[newCategory - 1].id
                    scrollProxy.scrollTo(scrollToCategoryID, anchor: .center)
                }
            }
            
            Divider()
                .padding(.bottom)
            
            TabView(selection: $selectedCategory) {
                ForEach(0...viewModel.categories.count, id: \.self) { index in
                    if index == 0 {
                        ProductsView(selectedCategory: $selectedCategory)
                            .tag(0)
                    } else {
                        ProductsView(selectedCategory: $selectedCategory)
                            .tag(viewModel.categories[index-1].id)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FilterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cornerRadius(8)
    }
}

struct CategoryButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(isSelected ? .black : .gray)
            .cornerRadius(8)
    }
}

#Preview {
    CategoryView()
}
