//
//  ResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/5/23.
//

import SwiftUI
struct ResultListView: View {
    var index: Int
    var str: String
    var place: String
    let jejuSpot : [JejuSpot]
    
    @State var description: String = ""
    @ObservedObject var locationManager : LocationManager
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.white)
                .opacity(0.5)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.orange_500)
                )
                .frame(width: Screen.maxWidth * 0.8, height: 80)
                .overlay(
                    HStack{
                        Image("map")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.leading, 20)
                        
                        VStack {
                            Text("\(str)")
                                .font(.custom("Pretendard_Regular", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .truncationMode(.tail)
                            if description == ""{
                                Text("정보를 불러올 수 없습니다.")
                                    .font(.custom("Pretendard_Regular", size: 15))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .truncationMode(.tail)
                            }else{
                                Text("\(description)")
                                    .font(.custom("Pretendard_Regular", size: 15))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .truncationMode(.tail)
                            }
                            
                            Spacer()
                        }
                        .padding([.leading,.trailing], 12)
                        .padding([.top], 15)
                        
                        NavigationLink {
                            DetailResultListView(jejuSpot: jejuSpot, locationManager: locationManager, index: index, keyword: place)
                        } label: {
                            Image("ChevronRightIcon_orange_f")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 24)
                        }
                    }
                        
                )
        }
        .onAppear{
            showDetail()
        }
    }
    
    func showDetail(){
        for i in 0..<jejuSpot.count{
            if jejuSpot[i].name == place{
                description = jejuSpot[i].introduction ?? ""
            }
        }
    }
}



