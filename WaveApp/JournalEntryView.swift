import SwiftUI
import AVKit

struct JournalEntryView: View {
    @State private var entries: [JournalEntry] = []
    @State private var showingImagePicker = false
    @State private var showingVideoPicker = false
    @State private var newEntryText: String = ""
    @State private var selectedImage: UIImage?
    @State private var selectedVideoURL: URL?
    @State private var mediaType: MediaType = .none

    enum MediaType {
        case none, photo, video
    }

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

                    HStack {
                        Button(action: {
                            mediaType = .photo
                            showingImagePicker = true
                        }) {
                            HStack {
                                Image(systemName: "photo")
                                Text("Add Photo")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }

                        Button(action: {
                            mediaType = .video
                            showingVideoPicker = true
                        }) {
                            HStack {
                                Image(systemName: "video")
                                Text("Add Video")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
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
                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            })
            .sheet(isPresented: $showingVideoPicker, content: {
                VideoPicker(selectedVideoURL: $selectedVideoURL, sourceType: .photoLibrary)
            })
        }
    }

    private func addEntry() {
        var mediaURL: URL? = nil
        if let selectedImage = selectedImage {
            mediaURL = saveImageLocally(image: selectedImage)
            self.selectedImage = nil
        } else if let selectedVideoURL = selectedVideoURL {
            mediaURL = saveMediaLocally(url: selectedVideoURL)
            self.selectedVideoURL = nil
        }
        let newEntry = JournalEntry(date: Date(), text: newEntryText, media: mediaURL)
        entries.append(newEntry)
        newEntryText = ""
    }

    private func saveImageLocally(image: UIImage) -> URL? {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageURL = documentsURL.appendingPathComponent(UUID().uuidString + ".jpg")

        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        do {
            try data.write(to: imageURL)
            return imageURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }

    private func saveMediaLocally(url: URL?) -> URL? {
        guard let url = url else { return nil }
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsURL.appendingPathComponent(url.lastPathComponent)

        do {
            if fileManager.fileExists(atPath: destinationURL.path) {
                try fileManager.removeItem(at: destinationURL)
            }
            try fileManager.copyItem(at: url, to: destinationURL)
            return destinationURL
        } catch {
            print("Error saving media: \(error)")
            return nil
        }
    }
}

struct JournalEntryView_Previews: PreviewProvider {
    static var previews: some View {
        JournalEntryView()
    }
}

