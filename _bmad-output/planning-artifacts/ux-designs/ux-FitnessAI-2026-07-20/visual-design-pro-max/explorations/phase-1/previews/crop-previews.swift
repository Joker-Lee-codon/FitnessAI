import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

let previewDirectory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let cropHeight = 1250

for direction in ["a", "b", "c"] {
    let sourceURL = previewDirectory.appendingPathComponent("direction-\(direction).png")
    guard
        let source = CGImageSourceCreateWithURL(sourceURL as CFURL, nil),
        let image = CGImageSourceCreateImageAtIndex(source, 0, nil)
    else {
        fatalError("Unable to read \(sourceURL.path)")
    }

    let targetHeight = min(cropHeight, image.height)
    let cropRect = CGRect(
        x: 0,
        y: 0,
        width: image.width,
        height: targetHeight
    )
    guard let cropped = image.cropping(to: cropRect) else {
        fatalError("Unable to crop \(sourceURL.path)")
    }

    let outputURL = previewDirectory.appendingPathComponent("direction-\(direction)-review.png")
    guard let destination = CGImageDestinationCreateWithURL(
        outputURL as CFURL,
        UTType.png.identifier as CFString,
        1,
        nil
    ) else {
        fatalError("Unable to create \(outputURL.path)")
    }
    CGImageDestinationAddImage(destination, cropped, nil)
    guard CGImageDestinationFinalize(destination) else {
        fatalError("Unable to write \(outputURL.path)")
    }
}
