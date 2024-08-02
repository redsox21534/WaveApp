import SwiftUI

struct ProfileView: View {
    @Binding var journalEntries: [JournalEntry]
    @Binding var journalFolders: [JournalFolder]
    @State private var isImagePickerPresented = false
    @State private var profileImage: UIImage? = UIImage(systemName: "person.crop.circle")
    @State private var userName: String = "Name"
    @State private var userBio: String = "Bio"
    @State private var selectedEntry: JournalEntry?
    @State private var selectedTab = 0 // 0 for Recents, 1 for Journals
    
    var body: some View {
        NavigationView {
            VStack {
                // Profile header
                VStack {
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
                
                // Segmented control
                Picker("Select Tab", selection: $selectedTab) {
                    Text("Recents").tag(0)
                    Text("Journals").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Content based on selected tab
                if selectedTab == 0 {
                    // Recents view
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(journalEntries.prefix(10).reversed()) { entry in
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
                } else {
                    // Journals view with folders
                    ScrollView {
                        VStack {
                            ForEach(journalFolders) { folder in
                                NavigationLink(destination: JournalFolderView(folder: folder)) {
                                    Text(folder.name)
                                        .font(.headline)
                                        .padding()
                                        .background(Color(.secondarySystemBackground))
                                        .cornerRadius(10)
                                        .padding([.leading, .trailing, .top])
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $profileImage, sourceType: .photoLibrary)
            }
        }
    }
}

struct JournalFolder: Identifiable {
    var id = UUID()
    var name: String
    var entries: [JournalEntry]
}

struct JournalFolderView: View {
    var folder: JournalFolder
    
    var body: some View {
        VStack {
            Text(folder.name)
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(folder.entries) { entry in
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
            
            Spacer()
        }
        .navigationBarTitle(folder.name, displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(journalEntries: .constant([]), journalFolders: .constant([]))
    }
}

//import SwiftUI
//
//struct ProfileView: View {
//    @Binding var journalEntries: [JournalEntry]
//    @Binding var journalFolders: [JournalFolder]
//    @State private var isImagePickerPresented = false
//    @State private var profileImage: UIImage? = UIImage(systemName: "person.crop.circle")
//    @State private var userName: String = "Name"
//    @State private var userBio: String = "Bio"
//    @State private var selectedEntry: JournalEntry?
//    @State private var selectedTab = 0 // 0 for Recents, 1 for Journals
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Profile header
//                VStack {
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
//                // Segmented control
//                Picker("Select Tab", selection: $selectedTab) {
//                    Text("Recents").tag(0)
//                    Text("Journals").tag(1)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//                
//                // Content based on selected tab
//                if selectedTab == 0 {
//                    // Recents view
//                    ScrollView {
//                        VStack(alignment: .leading) {
//                            ForEach(journalEntries.prefix(10).reversed()) { entry in
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
//                } else {
//                    // Journals view with folders
//                    ScrollView {
//                        VStack {
//                            ForEach(journalFolders) { folder in
//                                NavigationLink(destination: JournalFolderView(folder: folder)) {
//                                    Text(folder.name)
//                                        .font(.headline)
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
//struct JournalFolder: Identifiable {
//    var id = UUID()
//    var name: String
//    var entries: [JournalEntry]
//}
//
//struct JournalFolderView: View {
//    var folder: JournalFolder
//    
//    var body: some View {
//        VStack {
//            Text(folder.name)
//                .font(.largeTitle)
//                .padding()
//            
//            ScrollView {
//                VStack(alignment: .leading) {
//                    ForEach(folder.entries) { entry in
//                        Text("\(entry.date, style: .date), \(entry.date, style: .time): \(entry.title.isEmpty ? String(entry.content.prefix(50)) + "..." : entry.title)")
//                            .font(.headline)
//                            .lineLimit(1)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(10)
//                            .padding([.leading, .trailing, .top])
//                    }
//                }
//            }
//            
//            Spacer()
//        }
//        .navigationBarTitle(folder.name, displayMode: .inline)
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(journalEntries: .constant([]), journalFolders: .constant([]))
//    }
//}


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
//                        ForEach(journalEntries.reversed()) { entry in
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
//                .frame(maxHeight: .infinity)
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
