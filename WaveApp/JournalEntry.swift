import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    var date: Date
    var text: String
    var media: URL? // URL to the photo or video
}

