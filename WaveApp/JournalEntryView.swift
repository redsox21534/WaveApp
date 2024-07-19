import SwiftUI
import PhotosUI
import AVKit

struct JournalEntryView: View {
    @State private var entries: [JournalEntry] = []
    @State private var showingImagePicker = false
    @State private var newEntryText: String = ""
    @State private var selectedMediaURL: URL?

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(entries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.text)
                            if let mediaURL = entry.media {
                                if mediaURL.pathExtension.lowercased() == "jpg" || mediaURL.pathExtension.lowercased() == "png" {
                                    Image(uiImage: UIImage(contentsOfFile: mediaURL.path)!)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                } else if mediaURL.pathExtension.lowercased() == "mp4" || mediaURL.pathExtension.lowercased() == "mov" {
                                    VideoPlayer(player: AVPlayer(url: mediaURL))
                                        .frame(height: 200)
                                }
                            }
                            Text(entry.date, style: .date)
                                .font(.caption)
                        }
                        .padding(.vertical, 10)
                    }
                }

                Spacer()

                VStack {
                    TextEditor(text: $newEntryText)
                        .border(Color.gray)
                        .frame(height: 100)
                        .padding()

                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Add Photo/Video")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: addEntry) {
                        Text("Save Entry")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Journal")
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePicker(mediaURL: $selectedMediaURL)
            })
        }
    }

    private func addEntry() {
        let newEntry = JournalEntry(date: Date(), text: newEntryText, media: selectedMediaURL)
        entries.append(newEntry)
        newEntryText = ""
        selectedMediaURL = nil
    }
}

struct JournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryView()
    }
}

