//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct MainScreenView: View {
    
    @StateObject var mainScreenViewModel = MainScreenViewModel()
    @State private var isPresent = false
    @Binding var filterPresentation: Bool
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        Button {
                            
                        } label: {
                            HStack {
                                Image("Group")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 15)
                                Text("Zihuatanejo, Gro")
                                    .font(.custom(regularMark, size: 15))
                                    .foregroundColor(.black)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.appGrey)
                            }
                        }
                        .frame(alignment: .center)
                        
                        VStack(alignment: .trailing) {
                            Button {
                                
                            } label: {
                                Image("funnel")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 11, height: 13)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.vertical)
                .padding(.horizontal, 25)
                
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Select category")
                                .font(.custom(regularMark, size: 25).bold())
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
                                ForEach(SalesCategory.allCases, id: \.self) { category in
                                    salesCategoryView(category: category)
                                        .onTapGesture {
                                            switchSalesCategory(category: category)
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
                                    .shadow(color: .black.opacity(0.1), radius: 7)
                                    .frame(maxWidth: .infinity)
                            )
                            ZStack {
                                Button {
                                    
                                } label: {
                                    ZStack {
                                        Circle()
                                            .fill(Color.appOrange)
                                        Image("group 3")
                                            .resizable()
                                            .renderingMode(.template)
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 15)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .frame(maxWidth: 50)
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 25)
                        
                        HStack {
                            Text("Hot sales")
                                .font(.custom(regularMark, size: 25).bold())
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
                                ForEach(mainScreenViewModel.hotSales, id: \.self) { item in
                                    hotSalesView(hotSalesData: item)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .shadow(color: Color.black.opacity(0.14), radius: 10)
                        }
                        .frame(height: 200)
                        
                        HStack {
                            Text("Best Seller")
                                .font(.custom(regularMark, size: 25).bold())
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
                            ForEach(mainScreenViewModel.bestSellers, id: \.self) { item in
                                productCardView(bestSeller: item)
                            }
                        }
                        .padding(.horizontal, 13)
                        .padding(.vertical)
                    }
                }
            }
            .onAppear {
                mainScreenViewModel.fetchData()
            }
        }
        .background(Color.appBackground)
    }
}

// MARK: - Sales category circle view with text
extension MainScreenView {
    @ViewBuilder
    private func salesCategoryView(category: SalesCategory) -> some View {
        VStack {
            ZStack {
                Circle()
                    .fill(mainScreenViewModel.salesCategory == category ? Color.appOrange : Color.white)
                    .frame(width: 71, height: 71)
                    .shadow(color: .black.opacity(0.1), radius: 10)
                
                Image(systemName: category.imageName)
                    .font(.system(size: 30))
                    .foregroundColor(mainScreenViewModel.salesCategory == category ? Color.white : Color.imageCategory)
            }
            
            Text(category.title)
                .font(.custom(regularMark, size: 12))
                .foregroundColor(mainScreenViewModel.salesCategory == category ? Color.appOrange : Color.black)
        }
    }
    
    private func switchSalesCategory(category: SalesCategory) {
        withAnimation {
            mainScreenViewModel.salesCategory = category
        }
    }
}

//MARK: - Hot sales tab view
extension MainScreenView {
    @ViewBuilder
    private func hotSalesView(hotSalesData: home_store) -> some View {
        HStack {
            VStack(alignment: .leading) {
                if let _ = hotSalesData.is_new {
                    Text("new")
                        .font(.custom(regularMark, size: 10).bold())
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            Circle()
                                .fill(Color.appOrange)
                        )
                }
                VStack(alignment: .leading) {
                    Text(hotSalesData.title)
                        .font(.custom(regularMark, size: 25).bold())
                        .foregroundColor(.white)
                    Text(hotSalesData.subtitle)
                        .font(.custom(regularMark, size: 11))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Buy now!")
                font(.custom(regularMark, size: 11).bold())
                    .padding(.vertical, 7)
                    .padding(.horizontal, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                    )
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
extension MainScreenView {
    @ViewBuilder
    private func productCardView(bestSeller: best_seller) -> some View {
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
                            
                            Image(systemName: bestSeller.is_favorites ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 11)
                                .foregroundColor(Color.appOrange)
                                .background(
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 25, height: 25)
                                        .shadow(color: .black.opacity(0.1), radius: 10)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Spacer()
                }
                .frame(maxHeight: .infinity)
                .padding()
                
            }
            
            HStack(alignment: .bottom) {
                Text("$" + "\(bestSeller.price_without_discount)")
                    .font(.custom(regularMark, size: 16)).bold()
                Text("$" + "\(bestSeller.discount_price)")
                    .font(.custom(regularMark, size: 10))
                    .foregroundColor(Color.black.opacity(0.3))
                Spacer()
            }
            .padding(.horizontal, 16)
            
            HStack {
                Text(bestSeller.title)
                    .font(.custom(regularMark, size: 10))
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .padding(.bottom)
            

        }
        .frame(width: UIScreen.main.bounds.width / 2.3, height: UIScreen.main.bounds.height / 3)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: Color.black.opacity(0.1), radius: 12)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(filterPresentation: .constant(false))
    }
}
