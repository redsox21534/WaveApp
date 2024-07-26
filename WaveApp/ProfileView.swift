import SwiftUI

struct ProfileView: View {
    @Binding var journalEntries: [JournalEntry]
    @State private var isImagePickerPresented = false
    @State private var profileImage: UIImage? = UIImage(systemName: "person.crop.circle")
    @State private var userName: String = "Name"
    @State private var userBio: String = "Bio"
    @State private var selectedEntry: JournalEntry?

    var body: some View {
        NavigationView {
            VStack {
                // Profile header
                VStack {
                    // User avatar and information
                    if let profileImage = profileImage {
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding()
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding()
                            .onTapGesture {
                                isImagePickerPresented = true
                            }
                    }
                    TextField("Enter your name", text: $userName)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.leading, .trailing])
                    TextField("Enter your bio", text: $userBio)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.leading, .trailing, .bottom])
                }
                
                Divider()
                
                // Posts label
                Text("Posts")
                    .font(.headline)
                    .padding(.top)
                
                // Journal entries section
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(journalEntries.reversed()) { entry in
                            VStack(alignment: .leading) {
                                NavigationLink(destination: JournalDetailView(entry: entry)) {
                                    Text("\(entry.date, style: .date), \(entry.date, style: .time): \(entry.title.isEmpty ? String(entry.content.prefix(50)) + "..." : entry.title)")
                                        .font(.headline)
                                        .lineLimit(1)
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(10)
                                        .padding([.leading, .trailing, .top])
                                }
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $profileImage, sourceType: .photoLibrary)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(journalEntries: .constant([]))
    }
}

//
//import SwiftUI
//
//struct ProfileView: View {
//    @Binding var journalEntries: [JournalEntry]
//    @State private var isImagePickerPresented = false
//    @State private var profileImage: UIImage? = UIImage(systemName: "person.crop.circle")
//    @State private var userName: String = "Name"
//    @State private var userBio: String = "Bio"
//    @State private var selectedEntry: JournalEntry?
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Profile header
//                VStack {
//                    // User avatar and information
//                    if let profileImage = profileImage {
//                        Image(uiImage: profileImage)
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
//                            .padding()
//                            .onTapGesture {
//                                isImagePickerPresented = true
//                            }
//                    } else {
//                        Image(systemName: "person.crop.circle.fill")
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
//                            .padding()
//                            .onTapGesture {
//                                isImagePickerPresented = true
//                            }
//                    }
//                    TextField("Enter your name", text: $userName)
//                        .font(.title2)
//                        .multilineTextAlignment(.center)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding([.leading, .trailing])
//                    TextField("Enter your bio", text: $userBio)
//                        .font(.subheadline)
//                        .multilineTextAlignment(.center)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding([.leading, .trailing, .bottom])
//                }
//                
//                Divider()
//                
//                // Posts label
//                Text("Posts")
//                    .font(.headline)
//                    .padding(.top)
//                
//                // Journal entries section
//                ScrollView {
//                    VStack(alignment: .leading) {
//                        ForEach(journalEntries.prefix(10).reversed()) { entry in
//                            VStack(alignment: .leading) {
//                                NavigationLink(destination: JournalDetailView(entry: entry)) {
//                                    Text("\(entry.date, style: .date), \(entry.date, style: .time): \(entry.title.isEmpty ? String(entry.content.prefix(50)) + "..." : entry.title)")
//                                        .font(.headline)
//                                        .lineLimit(1)
//                                        .padding()
//                                        .background(Color(.secondarySystemBackground))
//                                        .cornerRadius(10)
//                                        .padding([.leading, .trailing, .top])
//                                }
//                            }
//                        }
//                    }
//                }
//                
//                Spacer()
//            }
//            .navigationBarTitle("Profile", displayMode: .inline)
//            .sheet(isPresented: $isImagePickerPresented) {
//                ImagePicker(selectedImage: $profileImage, sourceType: .photoLibrary)
//            }
//        }
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(journalEntries: .constant([]))
//    }
//}
//
