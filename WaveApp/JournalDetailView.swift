import SwiftUI

struct JournalDetailView: View {
    var entry: JournalEntry

    var body: some View {
        VStack {
            Text(entry.title)
                .font(.largeTitle)
                .padding()

            Text(entry.content)
                .padding()

            if let image = entry.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }

            if let videoURL = entry.videoURL {
                VideoPlayerView(url: videoURL)
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle(entry.title, displayMode: .inline)
    }
}

struct JournalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDetailView(entry: JournalEntry(title: "Sample Title", content: "Sample Content", date: Date()))
    }
}

//import SwiftUI
//import AVKit
//
//struct JournalDetailView: View {
//    var entry: JournalEntry
//
//    var body: some View {
//        VStack {
//            Text(entry.title.isEmpty ? "Journal Entry" : entry.title)
//                .font(.largeTitle)
//                .padding()
//
//            if let image = entry.image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
//                    .padding()
//            } else if let videoURL = entry.videoURL {
//                VideoPlayerView(url: videoURL)
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
//                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
//                    .padding()
//            }
//
//            Text(entry.content)
//                .padding()
//
//            Spacer()
//        }
//        .navigationBarTitle(Text(entry.date, style: .date), displayMode: .inline)
//    }
//}
//
//struct JournalDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        JournalDetailView(entry: JournalEntry(title: "Sample Entry", content: "This is the content of the journal entry.", date: Date(), image: nil, videoURL: nil))
//    }
//}
//
