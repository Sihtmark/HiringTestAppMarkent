//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var showingSheet = false
    @State private var filterPriceWidth: CGFloat = 25
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    bar
                    Button("Count") {
                        print(vm.hotSales.count)
                        print(vm.bestSeller.count)
                    }
                    ScrollView(.vertical, showsIndicators: true) {
                        selectCategorySection
                        hotSalesSection
                        bestSellerSection
                    }
                    HStack {
                        Spacer()
                        HStack {
                            Circle()
                                .frame(width: 8)
                                .foregroundColor(.white)
                            Text("Explorer")
                                .font(.custom(boldMark, size: 15))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Image("cart")
                        Spacer()
                        Image("heart")
                        Spacer()
                        Image("profile")
                        Spacer()
                    }
                    .frame(height: 72)
                    .background(Color.appBlue)
                    .cornerRadius(30)
                    
                    HStack {
                        Spacer()
                    }
                    .background(Color.appBlue)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .background(Color.appBackground)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .environmentObject(vm.favorites)
        .task {
            await vm.getProducts()
            await vm.getProductsOfCategory(category: "smartphones")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    var bar: some View {
        HStack {
            ZStack {
                Button {
                    
                } label: {
                    HStack {
                        Image("metka")
                        Text("Zihuatanejo, Gro")
                            .font(.custom(mediumMark, size: 20))
                            .foregroundColor(Color.black)
                        Image("arrow")
                    }
                }
                .frame(alignment: .center)
                
                VStack(alignment: .trailing) {
                    Button(action: {
                        self.showingSheet.toggle()
                    }) {
                        Image("filter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15)
                    }
                    .sheet(isPresented: $showingSheet) {
                        DetailView()
                            .presentationDetents([.fraction(0.5)])
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
            
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .background(Color.white)
    }
    
    var selectCategorySection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Select Category")
                    .font(.custom(boldMark, size: 25))
                Spacer()
                Button {
                    
                } label: {
                    Text("view all")
                        .font(.custom(regularMark, size: 15))
                        .foregroundColor(Color.appOrange)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 23) {
                    ForEach(ProductType.allCases, id: \.self) { type in
                        ProductTypeCircle(type: type)
                            .onTapGesture {
                                vm.switchProuductType(type: type)
                            }
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 25)
            }
            HStack {
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(Color.appOrange)
                    }
                    TextField("Search", text: .constant(""))
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .fill(.white)
                        .shadow(color: Color.shadow, radius: 20)
                        .frame(maxWidth: .infinity)
                )
                
                ZStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.appOrange)
                                .shadow(color: Color.shadow, radius: 20)
                            Image("qrCode")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 20)
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .frame(maxWidth: 50)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 25)
        }
    }
    
    var hotSalesSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Hot sales")
                    .font(.custom(boldMark, size: 25))
                Spacer()
                Button {
                    
                } label: {
                    Text("see more")
                        .font(.custom(regularMark, size: 15))
                        .foregroundColor(Color.appOrange)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 25)
            VStack {
                TabView {
                    ForEach(vm.hotSales, id: \.self) { product in
                        HotSalesCell(product: product)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .shadow(color: Color.black.opacity(0.14), radius: 10)
            }
            .frame(height: 200)
        }
    }
    
    var bestSellerSection: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Best seller")
                    .font(.custom(boldMark, size: 25))
                Spacer()
                Button {
                    
                } label: {
                    Text("see more")
                        .font(.custom(regularMark, size: 15))
                        .foregroundColor(Color.appOrange)
                }
            }
            .padding(.top, 10)
            .padding(.horizontal, 25)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(vm.bestSeller, id: \.self) { bestSeller in
                    BestSellerCell(bestSeller: bestSeller)
                }
            }
            .padding(.horizontal, 13)
            .padding(.vertical)
        }
    }
}
