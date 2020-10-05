//
//  UIImageViewExtension.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "noimage"),
            options: nil)
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
}
