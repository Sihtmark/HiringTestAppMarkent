//
//  HomeStorePage.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-07.
//

import SwiftUI

struct HomeStorePage: View {
    var body: some View {
        VStack {
            
            HStack(alignment: .top) {
                
                HStack {}
                    .frame(width: 40, height: 19)
                
                HStack {
                    ZStack {
                        Image("Group")
                            .resizable()
                    }
                    .frame(width: 13.5, height: 15.3)
                    
                    Text("City")
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.702, green: 0.702, blue: 0.702))
                        .padding(.top, 2)
                }
                .frame(width: 297, height: 19)
                
                HStack {
                    ZStack {
                        Image("Воронка")
                            .resizable()
                    }
                    .frame(width: 11, height: 13)
                    .padding(.trailing, 32)
                }
                .frame(width: 40, height: 19, alignment: .trailing)
            }
            Spacer()
            
            ScrollView() {
                HStack {
                    Text("Select Category")
                    
                    Spacer()
                    
                    Text("View all")
                }
                
                
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(whiteCircles, id: \.id) { whiteCircle in
                            SalesCategoryCell(whiteCircle: whiteCircle)
                        }
                        .padding(6.5)
                    }
                    .padding(.leading, 8)
                    .padding(.top, 5)
                }
                
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(red: 1.079, green: 0.382, blue: 0.252))
                            .font(.system(size: 16))
                            .padding(.leading, 24)
                    }
                    .frame(width: 300, height: 34, alignment: .leading)
                    .background(.white)
                    .cornerRadius(50)
                    
                    Spacer()
                        .frame(width: 11)
                    
                    ZStack {
                        ZStack {
                            Image("group 3")
                                .resizable()
                        }
                        .frame(width: 14.78, height: 14.78)
                    }
                    .frame(width: 34, height: 34)
                    .background(Color(red: 1.079, green: 0.382, blue: 0.252))
                    .cornerRadius(50)
                }
                .padding(.top, 15)
            }
            .background(Color(red: 0.961, green: 0.961, blue: 0.961))
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStorePage()
    }
}
