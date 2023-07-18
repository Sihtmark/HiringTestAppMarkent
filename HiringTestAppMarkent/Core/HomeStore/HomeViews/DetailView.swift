//
//  DetailView.swift
//  HiringTestAppMarkent
//
//  Created by Sergei Poluboiarinov on 2022-12-21.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var brandFilterTitle = "Samsung"
    @State private var priceFilterTitle = "$300 - $500"
    
    var body: some View {
        VStack {
            title
            filterBrand
            filterPrice
            filterSize
        }
        .padding(.leading, 44)
        .padding(.trailing, 20)
        .padding(.vertical, 30)
        .shadow(color: .black.opacity(0.1), radius: 12)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension DetailView {
    
    var title: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "clear.fill")
                    .resizable()
                    .frame(width: 37, height: 37)
                    .foregroundColor(Color.appBlue)
            }
            Spacer()
            Text("Filter options")
                .font(.custom(regularMark, size: 18).bold())
                .padding(.leading, 25)
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.custom(regularMark, size: 18))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 21)
                    .padding(.vertical, 7)
                    .background(Color.appOrange)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 50)
    }
    
    var filterBrand: some View {
        VStack(alignment: .leading) {
            Text("Brand")
                .font(.custom(mediumMark, size: 18).bold())
            Menu {
                Button {
                    self.brandFilterTitle = "Iphone"
                } label: {
                    Text("iPhone")
                }
                Button {
                    self.brandFilterTitle = "Samsung"
                } label: {
                    Text("Samsung")
                }
                Button {
                    self.brandFilterTitle = "Motorola"
                } label: {
                    Text("Motorola")
                }
                Button {
                    self.brandFilterTitle = "Xiaomi"
                } label: {
                    Text("Xiaomi")
                }
            } label: {
                ZStack {
                    Capsule()
                        .foregroundColor(.white)
                        .frame(height: 37)
                    HStack {
                        Text(brandFilterTitle)
                            .font(.custom(regularMark, size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.imageCategory)
                    }
                    .frame(height: 37)
                .padding(.horizontal)
                }
            }
        }
        .padding(.bottom, 5)
    }
    
    var filterPrice: some View {
        VStack(alignment: .leading) {
            Text("Price")
                .font(.custom(mediumMark, size: 18).bold())
            Menu {
                Button {
                    self.priceFilterTitle = "$0 - $300"
                } label: {
                    Text("$0 - $300")
                }
                Button {
                    self.priceFilterTitle = "$300 - $500"
                } label: {
                    Text("$300 - $500")
                }
                Button {
                    self.priceFilterTitle = "$500 - $800"
                } label: {
                    Text("$500 - $800")
                }
                Button {
                    self.priceFilterTitle = "$800 - $1000"
                } label: {
                    Text("$800 - $1000")
                }
                Button {
                    self.priceFilterTitle = "$1000 - $2000"
                } label: {
                    Text("$1000 - $2000")
                }
                Button {
                    self.priceFilterTitle = "$2000 - $5000"
                } label: {
                    Text("$2000 - $5000")
                }
                Button {
                    self.priceFilterTitle = "$5000 - $10000"
                } label: {
                    Text("$5000 - $10000")
                }
            } label: {
                ZStack {
                    Capsule()
                        .foregroundColor(.white)
                        .frame(height: 37)
                    HStack {
                        Text(priceFilterTitle)
                            .font(.custom(regularMark, size: 18))
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.imageCategory)
                    }
                    .frame(height: 37)
                .padding(.horizontal)
                }
            }
        }
        .padding(.bottom, 5)
    }
    
    var filterSize: some View {
        VStack(alignment: .leading) {
            Text("Size")
                .font(.custom(mediumMark, size: 18).bold())
            ZStack {
                Capsule()
                    .foregroundColor(.white)
                    .frame(height: 37)
                HStack {
                    Text("4.5 to 5.5 inches")
                        .font(.custom(regularMark, size: 18))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.imageCategory)
                }
                .padding(.horizontal)
            }
        }
    }
}
