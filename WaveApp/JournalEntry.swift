import Foundation
import UIKit

struct JournalEntry: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var date: Date
    var image: UIImage?
    var videoURL: URL?
}

