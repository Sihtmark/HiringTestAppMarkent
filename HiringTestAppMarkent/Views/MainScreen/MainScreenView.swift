//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct MainScreenView: View {
    
    @StateObject var mainScreenViewModel = MainScreenViewModel()
    
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
                    }
                }
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




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
