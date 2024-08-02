import SwiftUI

struct MainView: View {
    @State private var journalEntries: [JournalEntry] = []
    @State private var journalFolders: [JournalFolder] = []

    var body: some View {
        TabView {
            ProgressJournalView(journalEntries: $journalEntries, journalFolders: $journalFolders)
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

            ProfileView(journalEntries: $journalEntries, journalFolders: $journalFolders)
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

//import SwiftUI
//
//struct MainView: View {
//    @State private var journalEntries: [JournalEntry] = []
//    
//    var body: some View {
//        TabView {
//            ProgressJournalView(journalEntries: $journalEntries)
//                .tabItem {
//                    Image(systemName: "book")
//                    Text("Journal")
//                }
//
//            WavesView()
//                .tabItem {
//                    Image(systemName: "waveform.path.ecg")
//                    Text("Waves")
//                }
//
//            ConnectView()
//                .tabItem {
//                    Image(systemName: "person.2")
//                    Text("Connect")
//                }
//
//            ProfileView(journalEntries: $journalEntries)
//                .tabItem {
//                    Image(systemName: "person.crop.circle")
//                    Text("Profile")
//                }
//        }
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
//
//
