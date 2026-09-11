import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

let directory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let mappings = [
    ("watch-pages.png", "watch-pages-review.png"),
    ("iphone-core-pages.png", "iphone-core-pages-review.png"),
    ("iphone-system-pages.png", "iphone-system-pages-review.png"),
    ("states.png", "states-review.png"),
    ("themes.png", "themes-review.png")
]

for (sourceName, outputName) in mappings {
    let sourceURL = directory.appendingPathComponent(sourceName)
    guard let source = CGImageSourceCreateWithURL(sourceURL as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        fatalError("Unable to read \(sourceURL.path)")
    }
    let cropHeight = min(1250, image.height)
    guard let cropped = image.cropping(to: CGRect(x: 0, y: 0, width: image.width, height: cropHeight)) else {
        fatalError("Unable to crop \(sourceURL.path)")
    }
    let outputURL = directory.appendingPathComponent(outputName)
    guard let destination = CGImageDestinationCreateWithURL(outputURL as CFURL, UTType.png.identifier as CFString, 1, nil) else {
        fatalError("Unable to create \(outputURL.path)")
    }
    CGImageDestinationAddImage(destination, cropped, nil)
    guard CGImageDestinationFinalize(destination) else {
        fatalError("Unable to write \(outputURL.path)")
    }
}
