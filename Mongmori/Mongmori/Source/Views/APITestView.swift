
import SwiftUI
import Foundation

struct APITestView: View {
    @StateObject var naverApiVM = APIService()
    var location = LocationManager()
    
    var body: some View {
        VStack{
            
            Button(action: {
                naverApiVM.fetchNaverAPIDirections(startLocation: (127.1058342,37.359708), endLocation: (129.075986, 35.179470))
            }, label: {
                Text("Button")
            })
            Text(naverApiVM.resultDistance ?? "")
                .onAppear{
                    testJson(jsonString: testJSON)
                    //                    print(location.lastLocation?.coordinate.latitude)   //Optional(33.416912)
                    //                    print(location.lastLocation?.coordinate.longitude)  //Optional(126.375697)
                    
                }
            ForEach(testJson(jsonString: testJSON).data,id: \.self){ index in
                if index.name == "성산일출봉"{
                    Text(index.address)
                    Text(index.lat)
                    Text(index.lon)
                    Text(index.name)
                    Text(index.phonNumber)
                    Text(index.placeURL)
                }
               
            }
        }
        
    }
    
}

