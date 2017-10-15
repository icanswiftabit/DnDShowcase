//
//  Cat.swift
//  DnDShowcase
//
//Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import MobileCoreServices

enum CatError: Error {
    case invalidTypeIdentifier
}

final class Cat: NSObject, Shareable {
    
    let name: String
    let image: UIImage

    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
        super.init()
    }
    
    var data: Data? {
        return """
            {
                "name": "\(name)",
                "image": "\(UIImageJPEGRepresentation(image, 1.0)!.base64EncodedString())"
            }
            """.data(using: .utf8)
    }
    
    init(data: Data) {
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        name = json["name"] as! String
        let imageData = Data(base64Encoded: json["image"] as! String)!
        image = UIImage(data: imageData)!
        super.init()
    }
}

// Providing Cat to destinationApp
extension Cat: NSItemProviderWriting {
    
    // Tell which identifiers are cat will be conforming to
    static var writableTypeIdentifiersForItemProvider: [String] {
        // General identifiers are not recommended, specific identifiers are welcome
        return [Cat.shareIdentifier, kUTTypeImage as String, kUTTypePlainText as String]
    }
    
    // Prepare data for providing to destinationAPP
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        
        switch typeIdentifier {
        case Cat.shareIdentifier:
            completionHandler(data, nil)
        case kUTTypeImage as NSString as String:
            completionHandler(UIImageJPEGRepresentation(image, 1.0), nil)
        case kUTTypePlainText as NSString as String:
            completionHandler(name.data(using: .utf8), nil)
        default:
            completionHandler(nil, CatError.invalidTypeIdentifier)
        }
        
        // I'm not returning any progress
        return nil
    }
}

// Receiving cat from sourceApp
extension Cat: NSItemProviderReading {
    
    // Tell which indentifiers cal will be expecting
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [Cat.shareIdentifier, kUTTypeImage as String, kUTTypePlainText as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Cat {
        
        switch typeIdentifier {
        case Cat.shareIdentifier:
            return Cat(data: data)
        case kUTTypeImage as NSString as String:
            return Cat(name: "no name", image: UIImage(data: data)!)
        case kUTTypePlainText as NSString as String:
            return Cat(name: String(data: data, encoding: .utf8)!, image: UIImage())
        default:
            throw CatError.invalidTypeIdentifier
        }
    }
}
