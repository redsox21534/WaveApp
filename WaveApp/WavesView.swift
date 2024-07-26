import SwiftUI
import MapKit

struct WavesView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                MapView(region: $region)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: zoomOut) {
                            Image(systemName: "minus.magnifyingglass")
                                .frame(width: 50, height: 50)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                                .padding()
                        }
                    }
                }
            }
            .navigationBarTitle("Explore the World", displayMode: .inline)
        }
    }

    private func zoomOut() {
        var span = region.span
        span.latitudeDelta = min(span.latitudeDelta * 2, 180)
        span.longitudeDelta = min(span.longitudeDelta * 2, 180)
        region.span = span
    }
}

struct WavesView_Previews: PreviewProvider {
    static var previews: some View {
        WavesView()
    }
}



//import SwiftUI
//
//struct WavesView: View {
//    var body: some View {
//        Text("Waves")
//            .font(.largeTitle)
//            .padding()
//    }
//}
//
//struct WavesView_Previews: PreviewProvider {
//    static var previews: some View {
//        WavesView()
//    }
//}
//
