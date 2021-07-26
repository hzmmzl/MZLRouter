//
//  RouterImage.swift
//  MZLRouter
//
//  Created by minzhaolin on 2021/7/26.
//

import UIKit

extension UIImage {
    func router_image(_ name: String) -> UIImage? {
        var reImage: UIImage?
        let path = Bundle(for: NSClassFromString("MZLRouter")!).resourcePath! as NSString
        let bundlePath = path.appendingPathComponent("MZLRouter.bundle")
        let bundle = Bundle(path: bundlePath)
        reImage = UIImage(named: name, in: bundle, compatibleWith: nil)
        if reImage != nil {
            return reImage!
        } else {
            return UIImage(named: name)
        }
    }
}
