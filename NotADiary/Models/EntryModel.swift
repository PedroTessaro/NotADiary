//
//  EntryModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 09/10/25.
//

import Foundation
import CloudKit
import UIKit

enum ImageFileType {
    case JPG(compressionQuality: CGFloat)
    case PNG
    
    var fileExtension: String {
        switch self {
        case .JPG(_):
            return ".jpg"
        case .PNG:
            return ".png"
        }
    }
}

enum ImageError: Error {
    case UnableToConvertImageToData
}

extension CKAsset {
    convenience init(image: UIImage, fileType: ImageFileType = .JPG(compressionQuality: 70)) throws {
        let url = try image.saveToTempLocationWithFileType(fileType: fileType)
        self.init(fileURL: url as URL)
    }
}

extension UIImage {
    func saveToTempLocationWithFileType(fileType: ImageFileType) throws -> NSURL {
        let imageData: NSData?
        
        switch fileType {
        case .JPG(let quality):
            imageData = self.jpegData(compressionQuality: quality) as NSData?
        case .PNG:
            imageData = self.pngData() as NSData?
        }
        
        guard let data = imageData else {
            throw ImageError.UnableToConvertImageToData
        }
        
        let fileName = ProcessInfo.processInfo.globallyUniqueString + fileType.fileExtension
        let url = NSURL.fileURL(withPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        try data.write(to: url, options: .atomicWrite)
        
        return url as NSURL
    }
}
