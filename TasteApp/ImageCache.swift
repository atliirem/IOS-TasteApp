import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
