//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    @StateObject var favorites: FavoritesBestSellers = FavoritesBestSellers()
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
                    
                    ScrollView(.vertical, showsIndicators: true) {
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
                                        productTypeView(type: type)
                                            .onTapGesture {
                                                switchProuductType(type: type)
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
                                    ForEach(homeViewModel.hotSales, id: \.self) { item in
                                        hotSalesView(hotSalesData: item)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .shadow(color: Color.black.opacity(0.14), radius: 10)
                            }
                            .frame(height: 200)
                            
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
                                ForEach(homeViewModel.bestSeller, id: \.self) { bestSeller in
                                    productCardView(bestSeller: bestSeller)
                                }
                            }
                            .padding(.horizontal, 13)
                            .padding(.vertical)
                        }
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
                    .padding(.bottom, -20)
                    
                    HStack {
                        Spacer()
                    }
                    .background(Color.appBlue)
                }
                .onAppear {
                    homeViewModel.fetchData()
                }
            }
        }
        .background(Color.appBackground)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .environmentObject(favorites)
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
    }
}


// MARK: Product typeView
extension HomeView {
    @ViewBuilder
    private func productTypeView(type: ProductType) -> some View {
        VStack {
            ZStack {
                Circle()
                    .fill(homeViewModel.productType == type ? Color.appOrange : Color.white)
                    .frame(width: 71, height: 71)
                    .shadow(color: Color.shadow1, radius: 10)
                
                Image(type.imageName)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(homeViewModel.productType == type ? Color.white : Color.black.opacity(0.3))
            }
            
            Text(type.title)
                .font(.custom(regularMark, size: 14))
                .foregroundColor(homeViewModel.productType == type ? Color.appOrange : Color.black)
        }
        .background(Color.white)
    }
    
    private func switchProuductType(type: ProductType) {
        withAnimation {
            homeViewModel.productType = type
        }
    }
}

// MARK: Hot sales tabView
extension HomeView {
    @ViewBuilder
    private func hotSalesView(hotSalesData: HomeStore) -> some View {
        HStack {
            VStack(alignment: .leading) {
                
                if let _ = hotSalesData.isNew {
                    Text("New")
                        .font(.custom(regularMark, size: 10).bold())
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.appOrange)
                        )
                    
                }
                VStack(alignment: .leading) {
                    Text(hotSalesData.title)
                        .font(.custom(regularMark, size: 25).bold())
                        .foregroundColor(Color.white)
                    Text(hotSalesData.subtitle)
                        .font(.custom(regularMark, size: 11))
                        .foregroundColor(Color.white)
                }
                Spacer()
                NavigationLink {
                    ProductDetailsView()
                } label: {
                    Text("Buy now!")
                        .font(.custom(regularMark, size: 11).bold())
                        .foregroundColor(.black)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 30)
                        .background(
                            RoundedRectangle(cornerRadius: 9)
                                .fill(Color.white)
                        )
                }
                
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.horizontal, 6)
        .background(
            AsyncImage(url: hotSalesData.picture)
                .frame(height: 182)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        )
        .padding()
    }
}


// MARK: Best seller cardView
extension HomeView {
    @ViewBuilder
    private func productCardView( bestSeller: BestSeller) -> some View {
        NavigationLink {
            ProductDetailsView()
        } label: {
            VStack(spacing: 0) {
                ZStack {
                    AsyncImage(url: bestSeller.picture)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 4, alignment: .center)
                        .clipped()
                    VStack {
                        HStack() {
                            Spacer()
                            ZStack {
                                Button {
                                    if favorites.contains(bestSeller) {
                                        favorites.remove(bestSeller)
                                    } else {
                                        favorites.add(bestSeller)
                                    }
                                } label: {
                                    Image(systemName: favorites.contains(bestSeller) ? "heart.fill" : "heart")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 11)
                                        .foregroundColor(Color.appOrange)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .frame(width: 25, height: 25)
                                                .shadow(color: Color.shadow2, radius: 20)
                                        )
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    .padding()
                    
                }
                
                HStack(alignment: .bottom) {
                    Text("$" + "\(bestSeller.priceWithoutDiscount)")
                        .font(Font.custom(boldMark, size: 16))
                        .foregroundColor(.black)
                    Text("$" + "\(bestSeller.discountPrice)")
                        .font(.custom(mediumMark, size: 10))
                        .foregroundColor(Color.black.opacity(0.3))
                        .strikethrough(true, color: Color.black.opacity(0.3))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 6.5)
                
                HStack {
                    Text(bestSeller.title)
                        .font(.custom(regularMark, size: 10))
                        .foregroundColor(.black)
                    Spacer()
                    
                }
                .padding(.horizontal, 16)
                .padding(.bottom)
                
                
            }
            .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 3)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(color: Color.shadow1, radius: 40)
            )
        }
        
    }
}
