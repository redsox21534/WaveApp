import SwiftUI
import AVKit

struct ProgressJournalView: View {
    @Binding var journalEntries: [JournalEntry]
    @Environment(\.presentationMode) var presentationMode
    @State var selectedImage: UIImage?
    @State var selectedVideoURL: URL?
    @State var journalTitle: String = "New Journal Entry"
    @State var journalText: String = ""
    @State var showImagePicker: Bool = false
    @State var showVideoPicker: Bool = false
    @State var mediaType: MediaType = .none
    
    enum MediaType {
        case none, photo, video
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter title", text: $journalTitle)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                    .padding(.top)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
                        .frame(height: 250)
                        .padding(.horizontal)
                        .padding(.top)
                } else if let videoURL = selectedVideoURL {
                    VideoPlayerView(url: videoURL)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 1))
                        .frame(height: 250)
                        .padding(.horizontal)
                        .padding(.top)
                } else {
                    Text("Select a photo or video")
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top)
                }
                
                HStack {
                    Button(action: {
                        mediaType = .photo
                        showImagePicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Add Photo")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    Button(action: {
                        mediaType = .video
                        showVideoPicker = true
                    }) {
                        HStack {
                            Image(systemName: "video")
                            Text("Add Video")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Journal Entry")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                    
                    TextEditor(text: $journalText)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(16)
                        .frame(height: 150)
                        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                let newEntry = JournalEntry(
                    title: journalTitle,
                    content: journalText,
                    date: Date(),
                    image: selectedImage,
                    videoURL: selectedVideoURL
                )
                journalEntries.append(newEntry)
                clearFields()
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: mediaType == .photo ? $showImagePicker : $showVideoPicker) {
                if mediaType == .photo {
                    ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
                } else if mediaType == .video {
                    VideoPicker(selectedVideoURL: $selectedVideoURL, sourceType: .photoLibrary)
                }
            }
        }
    }
    
    private func clearFields() {
        journalTitle = "New Journal Entry"
        journalText = ""
        selectedImage = nil
        selectedVideoURL = nil
    }
}

struct ProgressJournalView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressJournalView(journalEntries: .constant([]))
    }
}

