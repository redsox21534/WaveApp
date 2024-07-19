import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ProgressJournalView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Journal")
                }

            WavesView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("Waves")
                }

            ConnectView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Connect")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

