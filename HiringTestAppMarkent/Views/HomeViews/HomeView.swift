//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showingSheet = false
//    @State private var filterPriceWidth: CGFloat = 25
    
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.width / 2.3), spacing: 15, alignment: .center),
        GridItem(.fixed(UIScreen.main.bounds.width / 2.3), spacing: 15, alignment: .center)
    ]
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    selectCategorySection
                    hotSalesSection
                    bestSellerSection
                }
                tabBar
            }
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    locationPicker
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    filterButton
                }
            }
            .sheet(isPresented: $showingSheet) {
                DetailView()
                    .presentationDetents([.fraction(0.5)])
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden(true)
        .task {
            if vm.bestSellers.isEmpty {
                await vm.getAllProducts()
            }
            await vm.getProductsOfCategory(category: vm.productType.rawValue)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}

extension HomeView {
    
    var selectCategorySection: some View {
        VStack {
            HStack {
                Text("Select Category")
                    .font(.custom(FontTheme.instance.boldMark, size: 25))
                    .fontWeight(.bold)
                Spacer()
                Button {
                    
                } label: {
                    Text("view all")
                        .font(.custom(FontTheme.instance.mediumMark, size: 15))
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(ProductType.allCases, id: \.self) { type in
                        Button(action: {
                            withAnimation {
                                vm.productType = type
                                Task {
                                    await vm.getProductsOfCategory(category: vm.productType.rawValue)
                                }
                            }
                        }, label: {
                            ProductTypeCircle(type: type)
                        })
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 10)
            HStack {
                ZStack {
                    Capsule()
                        .fill(.white)
                        .frame(maxWidth: .infinity)
                        .shadow(color: .black.opacity(0.15), radius: 10)
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.accentColor)
                                .padding(.horizontal, 24)
                                .cornerRadius(50)
                        }
                        TextField("Search", text: .constant(""))
                    }
                    .background(.white)
                    .padding(9)
                }
                
                ZStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.accentColor)
                                .shadow(color: .black.opacity(0.15), radius: 20)
                            Image.homeIcons.qrCode
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
            .padding()
        }
    }
    
    var hotSalesSection: some View {
        VStack {
            HStack {
                Text("Hot sales")
                    .font(.custom(FontTheme.instance.boldMark, size: 25))
                Spacer()
                Button {
                    
                } label: {
                    Text("see more")
                        .font(.custom(FontTheme.instance.regularMark, size: 15))
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal)
            VStack {
                TabView {
                    ForEach(vm.hotSales, id: \.self) { product in
                        HotSalesCell(product: product)
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .frame(height: 200)
            .padding(.vertical, 10)
        }
    }
    
    var bestSellerSection: some View {
        VStack {
            HStack {
                Text("Best seller")
                    .font(.custom(FontTheme.instance.boldMark, size: 25))
                Spacer()
                Button {
                    
                } label: {
                    Text("see more")
                        .font(.custom(FontTheme.instance.regularMark, size: 15))
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.horizontal)
            LazyVGrid(columns: columns, alignment: .center, spacing: 15) {
                ForEach(vm.bestSellers, id: \.self) { bestSeller in
                    BestSellerCell(bestSeller: bestSeller)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 100)
        }
    }
    
    var tabBar: some View {
        HStack {
            Spacer()
            HStack {
                Circle()
                    .frame(width: 8)
                    .foregroundColor(.white)
                Text("Explorer")
                    .font(.custom(FontTheme.instance.boldMark, size: 15))
                    .foregroundColor(.white)
            }
            Spacer()
            Image.homeIcons.cart
            Spacer()
            Image.homeIcons.heart
            Spacer()
            Image.homeIcons.profile
            Spacer()
        }
        .frame(height: 72)
        .frame(maxWidth: .infinity)
        .background(Color.theme.backgroundBlue)
        .cornerRadius(30)
    }
    
    var locationPicker: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image.homeIcons.metka
                Text("Zihuatanejo, Gro")
                    .font(.custom(FontTheme.instance.mediumMark, size: 20))
                    .foregroundColor(Color.black)
                Image.homeIcons.arrow
            }
        })
    }
    
    var filterButton: some View {
        Button(action: {
            showingSheet.toggle()
        }, label: {
            Image.homeIcons.filter
                .resizable()
                .scaledToFill()
                .frame(width: 13, height: 13)
        })
    }
}
