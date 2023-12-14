//
//  DetailResultListView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//

import SwiftUI
import KakaoSDKNavi
// MARK: - 리스트 상세 결과값

struct DetailResultListView: View {
    
    let jejuSpot : [JejuSpot]
    
    @ObservedObject var detailResultVM = DetailResultViewModel()
    @ObservedObject var naverApiVM = APIService()
    @ObservedObject var locationManager : LocationManager
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var clickedButtonLoad: Bool = true
    @State var clickedButtonCall: Bool = true
    @State var isShowSheet: Bool = false
    
    
    var index: Int
    var keyword: String
    
    func showDetailData(){
        for i in 0..<jejuSpot.count{
            if jejuSpot[i].name == keyword{
                
                dataIndex = i

//                jejuImage = parsingImageURL(url: jejuSpot[i].url ?? "")
                jejuImage = jejuSpot[i].url ?? ""
                
                textName = jejuSpot[i].name ?? ""
                
                textAddress = jejuSpot[i].address ?? ""
                
                let userLat = locationManager.lastLocation?.coordinate.latitude
                let userLon = locationManager.lastLocation?.coordinate.longitude
                
                naverApiVM.fetchNaverAPIDirections(startLocation: (userLat!,userLon!), endLocation: (jejuSpot[i].lat! , jejuSpot[i].lon! ))
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    textDistance = naverApiVM.resultDistance ?? ""
                }
                textDescription = jejuSpot[i].introduction ?? ""
                
            }
        }
    }

    
    @State var jejuImage = ""        //화면에 보여주는 여행지
    @State var textName = ""        //화면에 보여주는 여행지
    @State var textAddress = ""     //화면에 보여주는 주소
    @State var textDistance = ""    //화면에 보여주는 거리
    @State var dataIndex = 0        //해당하는 데이터 Index
    @State var textDescription = ""        //해당하는 데이터 설명란
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: jejuImage ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: Screen.maxWidth ,height: 250)
            // MARK: - 여행지 이름
            VStack(alignment: .leading){
                HStack{
                    Text(textName)
                        .font(.poppins(.NanumSquareOTF_acEB, size: 20)) //.font(.system(size: 20))  .fontWeight(.bold)
                    Spacer()
                }
                
            }
            .padding(
                EdgeInsets(
                    top: 24,
                    leading: 24,
                    bottom: 8,
                    trailing: 10
                )
            )
            
            // MARK: - 여행지 주소 및 거리 표시
            VStack{
                HStack{
                    Image("flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                    Text(textAddress)
                        .font(.poppins(.Pretendard_Regular, size: 16))  //.font(.system(size: 16))
                    Spacer()
                }

                
                HStack{
                    Image("flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)

                    
                    Text(textDistance+"Km")
                        .font(.poppins(.Pretendard_Regular, size: 16))  //.font(.system(size: 16))
                    Spacer()
                }
                .padding(.top, 5)
            }
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 24,
                    bottom: 12,
                    trailing: 10
                )
            )
            
            
            HStack{
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonLoad ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 45)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(clickedButtonLoad ? Color.orange_500 : Color.white, lineWidth: 2)
                            HStack {
                                Image(clickedButtonLoad ? "mapPinOrangeFill" : "mapPinLight" )
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                Text("길찾기")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(clickedButtonLoad ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonLoad.toggle()
                                isShowSheet.toggle()
                            }
                        }
                }
                .padding(.trailing, 10)
                
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(clickedButtonCall ? Color.white : Color.orange_500)
                        .frame(width: Screen.maxWidth * 0.38, height: 45)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(clickedButtonCall ? Color.orange_500 : Color.white, lineWidth: 2)
                            HStack {
                                
                                Image(clickedButtonCall ?
                                      "phoneOrangeFill" : "phoneLight")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                Text("전화하기")
                                    .font(.system(size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(clickedButtonCall ? Color.orange_500 : Color.white)
                            }
                            .onTapGesture {
                                clickedButtonCall.toggle()
                                detailResultVM.callButtonTapped(number: jejuSpot[dataIndex].phoneNumber ?? "")
                            }
                        }
                }
                .padding(.leading, 10)
                
                
                
            }
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 24,
                    bottom: 24,
                    trailing: 32
                )
            )
            
            VStack{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color.lightGray)
                    .frame(width: Screen.maxWidth * 0.8, height: 130)
                    .overlay{
                        VStack(alignment: .leading){
                            VStack{
                                HStack{
                                    Text("세부 정보")
                                        .font(.poppins(.NanumSquareOTF_acB, size: 16))           // .font(.system(size: 16)) //.fontWeight(.bold)
                                        .padding(
                                            EdgeInsets(
                                                top: 20,
                                                leading: 0,
                                                bottom: 16,
                                                trailing: 10
                                            )
                                        )
                                    Spacer()
                                }
                                
                            }
                            .padding(.leading,16)
                            VStack{
                                HStack{
                                    if textDescription != nil{
                                        Text(textDescription)   //  .font(.system(size: 14))  //.fontWeight(.regular)
                                            .font(.poppins(.Pretendard_Regular, size: 12))
                                    }else{
                                        Text("정보를 불러올 수 없습니다.")   //  .font(.system(size: 14))  //.fontWeight(.regular)
                                            .font(.poppins(.Pretendard_Regular, size: 12))
                                    }
                                   
                                    Spacer()
                                }
                               
                            }
                            .padding(.leading,16)
                            .padding(.bottom, 18)
                            Spacer()
                        }
                        .padding([.leading,.trailing],16)
                        .offset(x: -15)
                        
                    }
            }
            .padding(
                EdgeInsets(
                    top: 12,
                    leading: 24,
                    bottom: 12,
                    trailing: 24
                )
            )
            
            Spacer()
            
        }
        .sheet(isPresented: $isShowSheet) {
            NaverNaviView(locationManager: locationManager, endLat: jejuSpot[index].lat!, endLon: jejuSpot[index].lon!, place: textName)
                .presentationDetents([.large])
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        isShowSheet = false
                    }
                }
        }
        .onAppear{
            showDetailData()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("일정상세")         //  .font(.system(size: 20))  .fontWeight(.bold)
                    .font(.poppins(.NanumSquareOTF_acEB, size: 20))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("arrowLeft")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                }
            }
            
        }
    }

}

//#Preview {
//    DetailResultListView()
//}
