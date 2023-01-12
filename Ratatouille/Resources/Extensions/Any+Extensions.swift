//
//  Any+Extensions.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation
import UIKit


extension String {
    

    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
  
}


extension UIColor {
 
    static func appColor(_ name: Constants.AssetsColor) -> UIColor? {
       return UIColor(named: name.rawValue)
    }
    
}


extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}
